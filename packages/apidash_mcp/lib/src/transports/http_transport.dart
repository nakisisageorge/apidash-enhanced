// MCP HTTP/SSE Transport
library apidash_mcp.transports.http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/mcp_models.dart';
import '../auth/auth_manager.dart';
import '../config/mcp_config.dart';

/// HTTP/SSE transport for MCP server
class HttpMcpServer {
  final McpServerInterface server;
  final String host;
  final int port;
  final AuthManager authManager;
  HttpServer? _httpServer;
  final Map<String, WebSocketChannel> _wsConnections = {};

  HttpMcpServer({
    required this.server,
    required this.host,
    required this.port,
    required this.authManager,
  });

  Future<void> start() async {
    _httpServer = await HttpServer.bind(host, port);
    _httpServer!.listen(_handleRequest);
    print('API Dash MCP HTTP Server listening on $host:$port');
  }

  void _handleRequest(HttpRequest request) {
    // CORS headers
    request.response.headers.set('Access-Control-Allow-Origin', '*');
    request.response.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    request.response.headers.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      request.response.close();
      return;
    }

    // Auth check
    if (authManager.config.enabled) {
      final authHeader = request.headers.value('authorization');
      if (authHeader == null || !_validateAuth(authHeader)) {
        request.response.statusCode = HttpStatus.unauthorized;
        request.response.write(jsonEncode({'error': 'Unauthorized'}));
        request.response.close();
        return;
      }
    }

    switch (request.uri.path) {
      case '/mcp':
        _handleMcpEndpoint(request);
        break;
      case '/mcp/ws':
        _handleWebSocket(request);
        break;
      case '/sse':
        _handleSse(request);
        break;
      case '/health':
        _handleHealth(request);
        break;
      default:
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
    }
  }

  bool _validateAuth(String authHeader) {
    if (!authHeader.startsWith('Bearer ')) return false;
    final token = authHeader.substring(7);
    return authManager.validateToken(token);
  }

  void _handleMcpEndpoint(HttpRequest request) async {
    if (request.method != 'POST') {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.close();
      return;
    }

    try {
      final body = await request.transform(utf8.decoder).join();
      final jsonRequest = jsonDecode(body) as Map<String, dynamic>;
      final response = await _processMcpRequest(jsonRequest);
      request.response.headers.set('Content-Type', 'application/json');
      request.response.write(jsonEncode(response));
    } catch (e) {
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write(jsonEncode({
        'jsonrpc': '2.0',
        'id': null,
        'error': {'code': -32700, 'message': 'Parse error: $e'},
      }));
    }
    request.response.close();
  }

  Future<Map<String, dynamic>> _processMcpRequest(Map<String, dynamic> request) async {
    final id = request['id'];
    final method = request['method'] as String?;
    final params = request['params'] as Map<String, dynamic>?;

    if (method == null) {
      return {
        'jsonrpc': '2.0',
        'id': id,
        'error': {'code': -32600, 'message': 'Invalid request: missing method'},
      };
    }

    try {
      dynamic result;
      switch (method) {
        case 'initialize':
          result = {
            'protocolVersion': '2024-11-05',
            'capabilities': server.capabilities.toJson(),
            'serverInfo': {'name': 'apidash', 'version': '0.1.0'},
          };
          break;
        case 'tools/list':
          result = {'tools': server.tools.map((t) => t.toJson()).toList()};
          break;
        case 'tools/call':
          final name = params?['name'] as String?;
          final arguments = params?['arguments'] as Map<String, dynamic>?;
          if (name == null) throw ArgumentError('Tool name required');
          final tool = server.tools.firstWhere(
            (t) => t.name == name,
            orElse: () => throw ArgumentError('Tool not found: $name'),
          );
          final toolResult = await tool.execute(arguments ?? {});
          result = toolResult.toJson();
          break;
        case 'resources/list':
          result = {'resources': server.resources.map((r) => r.toJson()).toList()};
          break;
        case 'resources/read':
          final uri = params?['uri'] as String?;
          if (uri == null) throw ArgumentError('Resource URI required');
          final resource = server.resources.firstWhere(
            (r) => r.uri == uri,
            orElse: () => throw ArgumentError('Resource not found: $uri'),
          );
          final content = await resource.read();
          result = {'contents': [content.toJson()]};
          break;
        case 'prompts/list':
          result = {'prompts': server.prompts.map((p) => p.toJson()).toList()};
          break;
        case 'prompts/get':
          final name = params?['name'] as String?;
          if (name == null) throw ArgumentError('Prompt name required');
          final prompt = server.prompts.firstWhere(
            (p) => p.name == name,
            orElse: () => throw ArgumentError('Prompt not found: $name'),
          );
          final messages = await prompt.getMessages(params?['arguments'] as Map<String, dynamic>?);
          result = {
            'description': prompt.description,
            'messages': messages.map((m) => m.toJson()).toList(),
          };
          break;
        case 'ping':
          result = {};
          break;
        default:
          return {
            'jsonrpc': '2.0',
            'id': id,
            'error': {'code': -32601, 'message': 'Method not found: $method'},
          };
      }

      return {
        'jsonrpc': '2.0',
        'id': id,
        'result': result,
      };
    } catch (e, stack) {
      return {
        'jsonrpc': '2.0',
        'id': id,
        'error': {'code': -32603, 'message': 'Internal error: $e', 'data': stack.toString()},
      };
    }
  }

  void _handleWebSocket(HttpRequest request) async {
    final channel = WebSocketChannel(HttpRequestTransformer.upgrade(request));
    final connectionId = DateTime.now().millisecondsSinceEpoch.toString();

    _wsConnections[connectionId] = channel;

    channel.stream.listen(
      (message) => _handleWsMessage(connectionId, message),
      onDone: () => _wsConnections.remove(connectionId),
      onError: (e) => _wsConnections.remove(connectionId),
    );
  }

  void _handleWsMessage(String connectionId, dynamic message) async {
    final channel = _wsConnections[connectionId];
    if (channel == null) return;

    try {
      final request = jsonDecode(message as String) as Map<String, dynamic>;
      final response = await _processMcpRequest(request);
      channel.sink.add(jsonEncode(response));
    } catch (e) {
      channel.sink.add(jsonEncode({
        'jsonrpc': '2.0',
        'id': null,
        'error': {'code': -32700, 'message': 'Parse error: $e'},
      }));
    }
  }

  void _handleSse(HttpRequest request) {
    request.response.headers.set('Content-Type', 'text/event-stream');
    request.response.headers.set('Cache-Control', 'no-cache');
    request.response.headers.set('Connection', 'keep-alive');

    // Send initial endpoint event
    request.response.write('event: endpoint\ndata: /mcp\n\n');

    request.response.close();
  }

  void _handleHealth(HttpRequest request) {
    request.response.headers.set('Content-Type', 'application/json');
    request.response.write(jsonEncode({'status': 'ok', 'server': 'apidash-mcp'}));
    request.response.close();
  }

  Future<void> stop() async {
    await _httpServer?.close(force: true);
    for (final channel in _wsConnections.values) {
      await channel.sink.close();
    }
    _wsConnections.clear();
  }
}

/// Interface for MCP server implementation
abstract class McpServerInterface {
  McpCapabilities get capabilities;
  List<McpTool> get tools;
  List<McpResource> get resources;
  List<McpPrompt> get prompts;
}