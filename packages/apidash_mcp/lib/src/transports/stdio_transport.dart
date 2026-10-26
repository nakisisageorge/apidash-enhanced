// MCP stdio Transport
library apidash_mcp.transports.stdio;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../models/mcp_models.dart';

/// Stdio transport for MCP server
class StdioTransport {
  final McpServerInterface server;
  late final StreamController<String> _inputController;
  late final StreamSubscription<String> _inputSubscription;
  bool _running = false;

  StdioTransport({required this.server}) {
    _inputController = StreamController<String>.broadcast();
  }

  Future<void> start() async {
    if (_running) return;
    _running = true;

    stdin
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(_handleInput, onDone: _handleClose);

    stderr.writeln('API Dash MCP Server started on stdio');
  }

  void _handleInput(String line) {
    if (line.trim().isEmpty) return;

    try {
      final request = jsonDecode(line) as Map<String, dynamic>;
      _handleRequest(request);
    } catch (e) {
      _sendError(null, -32700, 'Parse error: $e');
    }
  }

  void _handleRequest(Map<String, dynamic> request) async {
    final id = request['id'];
    final method = request['method'] as String?;
    final params = request['params'] as Map<String, dynamic>?;

    if (method == null) {
      _sendError(id, -32600, 'Invalid request: missing method');
      return;
    }

    try {
      dynamic result;
      switch (method) {
        case 'initialize':
          result = await _handleInitialize(params);
          break;
        case 'tools/list':
          result = await _handleToolsList(params);
          break;
        case 'tools/call':
          result = await _handleToolCall(params);
          break;
        case 'resources/list':
          result = await _handleResourcesList(params);
          break;
        case 'resources/read':
          result = await _handleResourceRead(params);
          break;
        case 'prompts/list':
          result = await _handlePromptsList(params);
          break;
        case 'prompts/get':
          result = await _handlePromptGet(params);
          break;
        case 'ping':
          result = {};
          break;
        default:
          _sendError(id, -32601, 'Method not found: $method');
          return;
      }

      _sendResponse(id, result);
    } catch (e, stack) {
      _sendError(id, -32603, 'Internal error: $e', stack.toString());
    }
  }

  Future<Map<String, dynamic>> _handleInitialize(Map<String, dynamic>? params) async {
    return {
      'protocolVersion': '2024-11-05',
      'capabilities': server.capabilities.toJson(),
      'serverInfo': {
        'name': 'apidash',
        'version': '0.1.0',
      },
    };
  }

  Future<Map<String, dynamic>> _handleToolsList(Map<String, dynamic>? params) async {
    final tools = server.tools.map((t) => t.toJson()).toList();
    return {'tools': tools};
  }

  Future<Map<String, dynamic>> _handleToolCall(Map<String, dynamic>? params) async {
    final name = params?['name'] as String?;
    final arguments = params?['arguments'] as Map<String, dynamic>?;

    if (name == null) {
      throw ArgumentError('Tool name required');
    }

    final tool = server.tools.firstWhere(
      (t) => t.name == name,
      orElse: () => throw ArgumentError('Tool not found: $name'),
    );

    final result = await tool.execute(arguments ?? {});
    return result.toJson();
  }

  Future<Map<String, dynamic>> _handleResourcesList(Map<String, dynamic>? params) async {
    final resources = server.resources.map((r) => r.toJson()).toList();
    return {'resources': resources};
  }

  Future<Map<String, dynamic>> _handleResourceRead(Map<String, dynamic>? params) async {
    final uri = params?['uri'] as String?;
    if (uri == null) throw ArgumentError('Resource URI required');

    final resource = server.resources.firstWhere(
      (r) => r.uri == uri,
      orElse: () => throw ArgumentError('Resource not found: $uri'),
    );

    final content = await resource.read();
    return {
      'contents': [
        content.toJson(),
      ],
    };
  }

  Future<Map<String, dynamic>> _handlePromptsList(Map<String, dynamic>? params) async {
    final prompts = server.prompts.map((p) => p.toJson()).toList();
    return {'prompts': prompts};
  }

  Future<Map<String, dynamic>> _handlePromptGet(Map<String, dynamic>? params) async {
    final name = params?['name'] as String?;
    if (name == null) throw ArgumentError('Prompt name required');

    final prompt = server.prompts.firstWhere(
      (p) => p.name == name,
      orElse: () => throw ArgumentError('Prompt not found: $name'),
    );

    final messages = await prompt.getMessages(params?['arguments'] as Map<String, dynamic>?);
    return {
      'description': prompt.description,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  void _sendResponse(dynamic id, dynamic result) {
    final response = {
      'jsonrpc': '2.0',
      'id': id,
      'result': result,
    };
    stdout.writeln(jsonEncode(response));
  }

  void _sendError(dynamic id, int code, String message, [String? data]) {
    final response = {
      'jsonrpc': '2.0',
      'id': id,
      'error': {
        'code': code,
        'message': message,
        if (data != null) 'data': data,
      },
    };
    stdout.writeln(jsonEncode(response));
  }

  void _handleClose() {
    _running = false;
    _inputController.close();
  }

  Future<void> stop() async {
    _running = false;
    await _inputController.close();
  }
}

/// Interface for MCP server implementation
abstract class McpServerInterface {
  McpCapabilities get capabilities;
  List<McpTool> get tools;
  List<McpResource> get resources;
  List<McpPrompt> get prompts;
}