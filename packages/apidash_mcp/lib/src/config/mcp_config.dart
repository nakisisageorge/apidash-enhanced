// MCP Configuration for API Dash
library apidash_mcp.config;

import 'dart:io';

class McpConfig {
  final bool enableHttp;
  final String httpHost;
  final int httpPort;
  final AuthConfig authConfig;
  final String dataDirectory;
  final bool debugMode;

  McpConfig({
    this.enableHttp = false,
    this.httpHost = '127.0.0.1',
    this.httpPort = 3000,
    required this.authConfig,
    String? dataDirectory,
    this.debugMode = false,
  }) : dataDirectory = dataDirectory ?? _defaultDataDirectory();

  static String _defaultDataDirectory() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '.';
    return '$home/.apidash/mcp';
  }

  factory McpConfig.fromArgs(List<String> args) {
    bool enableHttp = false;
    String httpHost = '127.0.0.1';
    int httpPort = 3000;
    bool debugMode = false;
    String? dataDirectory;

    for (int i = 0; i < args.length; i++) {
      switch (args[i]) {
        case '--http':
          enableHttp = true;
          break;
        case '--host':
          if (i + 1 < args.length) {
            httpHost = args[++i];
          }
          break;
        case '--port':
          if (i + 1 < args.length) {
            httpPort = int.tryParse(args[++i]) ?? 3000;
          }
          break;
        case '--data-dir':
          if (i + 1 < args.length) {
            dataDirectory = args[++i];
          }
          break;
        case '--debug':
          debugMode = true;
          break;
      }
    }

    return McpConfig(
      enableHttp: enableHttp,
      httpHost: httpHost,
      httpPort: httpPort,
      authConfig: AuthConfig.fromEnv(),
      dataDirectory: dataDirectory,
      debugMode: debugMode,
    );
  }

  Map<String, dynamic> toJson() => {
    'enableHttp': enableHttp,
    'httpHost': httpHost,
    'httpPort': httpPort,
    'dataDirectory': dataDirectory,
    'debugMode': debugMode,
  };
}

class AuthConfig {
  final bool enabled;
  final String? apiKey;
  final Duration tokenExpiry;
  final List<String> allowedOrigins;

  AuthConfig({
    this.enabled = false,
    this.apiKey,
    this.tokenExpiry = const Duration(hours: 24),
    this.allowedOrigins = const ['http://localhost:3000', 'http://127.0.0.1:3000'],
  });

  factory AuthConfig.fromEnv() {
    final apiKey = Platform.environment['APIDASH_MCP_API_KEY'];
    final enabled = apiKey != null && apiKey.isNotEmpty;

    return AuthConfig(
      enabled: enabled,
      apiKey: enabled ? apiKey : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'tokenExpiry': tokenExpiry.inSeconds,
    'allowedOrigins': allowedOrigins,
  };
}