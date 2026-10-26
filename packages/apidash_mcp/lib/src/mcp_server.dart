part of apidash_mcp;

import 'dart:async';
import 'dart:io';

import 'package:mcp_server/mcp_server.dart';
import 'package:mcp_server_http/mcp_server_http.dart';

import '../tools/collection_tools.dart';
import '../tools/request_tools.dart';
import '../tools/codegen_tools.dart';
import '../tools/import_export_tools.dart';
import '../tools/ai_tools.dart';
import '../tools/environment_tools.dart';
import '../transports/stdio_transport.dart';
import '../transports/http_transport.dart';
import '../auth/auth_manager.dart';
import '../config/mcp_config.dart';
import '../models/mcp_models.dart';

/// Main MCP Server for API Dash
class ApidashMcpServer {
  final McpConfig config;
  final AuthManager authManager;
  late final McpServer _server;
  late final HttpMcpServer? _httpServer;
  late final StdioTransport _stdioTransport;

  ApidashMcpServer({
    required this.config,
    required this.authManager,
  }) {
    _initializeServer();
  }

  void _initializeServer() {
    _server = McpServer(
      name: 'apidash',
      version: '0.1.0',
      capabilities: McpCapabilities(
        tools: McpToolsCapability(listChanged: true),
        resources: McpResourcesCapability(subscribe: true, listChanged: true),
        prompts: McpPromptsCapability(listChanged: true),
      ),
    );

    _registerTools();
    _registerResources();
    _registerPrompts();

    _stdioTransport = StdioTransport(server: _server);

    if (config.enableHttp) {
      _httpServer = HttpMcpServer(
        server: _server,
        host: config.httpHost,
        port: config.httpPort,
        authManager: authManager,
      );
    }
  }

  void _registerTools() {
    // Collection tools
    _server.addTool(CreateCollectionTool());
    _server.addTool(ListCollectionsTool());
    _server.addTool(GetCollectionTool());
    _server.addTool(UpdateCollectionTool());
    _server.addTool(DeleteCollectionTool());
    _server.addTool(CreateFolderTool());
    _server.addTool(DeleteFolderTool());

    // Request tools
    _server.addTool(CreateRequestTool());
    _server.addTool(SendRequestTool());
    _server.addTool(GetRequestHistoryTool());
    _server.addTool(SaveRequestToCollectionTool());

    // Code generation tools
    _server.addTool(GenerateCodeTool());
    _server.addTool(ListSupportedLanguagesTool());

    // Import/Export tools
    _server.addTool(ImportCollectionTool());
    _server.addTool(ExportCollectionTool());
    _server.addTool(ImportFromCurlTool());
    _server.addTool(ImportFromPostmanTool());
    _server.addTool(ImportFromInsomniaTool());
    _server.addTool(ImportFromHarTool());
    _server.addTool(ImportFromOpenApiTool());

    // AI tools
    _server.addTool(AiGenerateRequestTool());
    _server.addTool(AiExplainResponseTool());
    _server.addTool(AiDebugRequestTool());
    _server.addTool(AiGenerateTestsTool());
    _server.addTool(AiGenerateDocumentationTool());

    // Environment tools
    _server.addTool(CreateEnvironmentTool());
    _server.addTool(ListEnvironmentsTool());
    _server.addTool(UpdateEnvironmentTool());
    _server.addTool(DeleteEnvironmentTool());
    _server.addTool(SetActiveEnvironmentTool());
  }

  void _registerResources() {
    _server.addResource(
      McpResource(
        uri: 'apidash://collections',
        name: 'API Collections',
        description: 'All API request collections',
        mimeType: 'application/json',
      ),
    );
    _server.addResource(
      McpResource(
        uri: 'apidash://environments',
        name: 'Environments',
        description: 'API environment variables',
        mimeType: 'application/json',
      ),
    );
    _server.addResource(
      McpResource(
        uri: 'apidash://history',
        name: 'Request History',
        description: 'Recent API request history',
        mimeType: 'application/json',
      ),
    );
    _server.addResource(
      McpResource(
        uri: 'apidash://supported-languages',
        name: 'Supported Code Generation Languages',
        description: 'Languages supported for code generation',
        mimeType: 'application/json',
      ),
    );
  }

  void _registerPrompts() {
    _server.addPrompt(
      McpPrompt(
        name: 'create-api-request',
        description: 'Create a new API request with best practices',
        arguments: [
          McpPromptArgument(name: 'method', description: 'HTTP method', required: true),
          McpPromptArgument(name: 'url', description: 'API endpoint URL', required: true),
          McpPromptArgument(name: 'auth', description: 'Authentication type', required: false),
        ],
      ),
    );
    _server.addPrompt(
      McpPrompt(
        name: 'debug-api-error',
        description: 'Debug an API error response',
        arguments: [
          McpPromptArgument(name: 'response', description: 'Error response', required: true),
          McpPromptArgument(name: 'request', description: 'Original request', required: false),
        ],
      ),
    );
    _server.addPrompt(
      McpPrompt(
        name: 'generate-api-tests',
        description: 'Generate test cases for an API endpoint',
        arguments: [
          McpPromptArgument(name: 'spec', description: 'OpenAPI spec or request example', required: true),
          McpPromptArgument(name: 'language', description: 'Target language', required: false),
        ],
      ),
    );
  }

  /// Start the MCP server with stdio transport
  Future<void> startStdio() async {
    await _stdioTransport.start();
  }

  /// Start the HTTP/SSE transport
  Future<void> startHttp() async {
    if (_httpServer != null) {
      await _httpServer!.start();
    }
  }

  /// Start both transports
  Future<void> start() async {
    await startStdio();
    if (config.enableHttp) {
      await startHttp();
    }
  }

  /// Stop the server
  Future<void> stop() async {
    await _stdioTransport.stop();
    if (_httpServer != null) {
      await _httpServer!.stop();
    }
  }
}

/// Main entry point for the MCP server
Future<void> main(List<String> args) async {
  final config = McpConfig.fromArgs(args);
  final authManager = AuthManager(config: config.authConfig);

  final server = ApidashMcpServer(
    config: config,
    authManager: authManager,
  );

  // Handle shutdown signals
  ProcessSignal.sigint.watch().listen((_) async {
    await server.stop();
    exit(0);
  });

  ProcessSignal.sigterm.watch().listen((_) async {
    await server.stop();
    exit(0);
  });

  await server.start();

  // Keep the server running
  await Future.delayed(Duration(days: 365));
}