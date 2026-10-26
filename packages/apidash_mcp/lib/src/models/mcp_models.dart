// MCP Models for API Dash (Plain Dart - no code generation needed)
library apidash_mcp.models;

import 'dart:async';

/// MCP Tool definition
class McpTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  McpTool({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'inputSchema': inputSchema,
  };

  factory McpTool.fromJson(Map<String, dynamic> json) => McpTool(
    name: json['name'] as String,
    description: json['description'] as String,
    inputSchema: json['inputSchema'] as Map<String, dynamic>,
  );

  /// Execute the tool with given arguments
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    throw UnimplementedError('Tool ${name} execute not implemented');
  }
}

/// MCP Resource definition
class McpResource {
  final String uri;
  final String name;
  final String description;
  final String? mimeType;

  McpResource({
    required this.uri,
    required this.name,
    required this.description,
    this.mimeType,
  });

  Map<String, dynamic> toJson() => {
    'uri': uri,
    'name': name,
    'description': description,
    if (mimeType != null) 'mimeType': mimeType,
  };

  factory McpResource.fromJson(Map<String, dynamic> json) => McpResource(
    uri: json['uri'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    mimeType: json['mimeType'] as String?,
  );

  /// Read the resource content
  Future<McpResourceContent> read() async {
    throw UnimplementedError('Resource ${uri} read not implemented');
  }
}

/// MCP Prompt definition
class McpPrompt {
  final String name;
  final String description;
  final List<McpPromptArgument> arguments;

  McpPrompt({
    required this.name,
    required this.description,
    this.arguments = const [],
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'arguments': arguments.map((a) => a.toJson()).toList(),
  };

  factory McpPrompt.fromJson(Map<String, dynamic> json) => McpPrompt(
    name: json['name'] as String,
    description: json['description'] as String,
    arguments: (json['arguments'] as List? ?? [])
        .map((a) => McpPromptArgument.fromJson(a as Map<String, dynamic>))
        .toList(),
  );

  /// Get prompt messages with optional arguments
  Future<List<McpPromptMessage>> getMessages(Map<String, dynamic>? arguments) async {
    throw UnimplementedError('Prompt ${name} getMessages not implemented');
  }
}

class McpPromptArgument {
  final String name;
  final String description;
  final bool required;

  McpPromptArgument({
    required this.name,
    required this.description,
    this.required = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'required': required,
  };

  factory McpPromptArgument.fromJson(Map<String, dynamic> json) => McpPromptArgument(
    name: json['name'] as String,
    description: json['description'] as String,
    required: json['required'] as bool? ?? false,
  );
}

/// MCP Capabilities
class McpCapabilities {
  final McpToolsCapability? tools;
  final McpResourcesCapability? resources;
  final McpPromptsCapability? prompts;

  McpCapabilities({
    this.tools,
    this.resources,
    this.prompts,
  });

  Map<String, dynamic> toJson() => {
    if (tools != null) 'tools': tools!.toJson(),
    if (resources != null) 'resources': resources!.toJson(),
    if (prompts != null) 'prompts': prompts!.toJson(),
  };
}

class McpToolsCapability {
  final bool listChanged;

  McpToolsCapability({this.listChanged = false});

  Map<String, dynamic> toJson() => {'listChanged': listChanged};
}

class McpResourcesCapability {
  final bool subscribe;
  final bool listChanged;

  McpResourcesCapability({this.subscribe = false, this.listChanged = false});

  Map<String, dynamic> toJson() => {
    'subscribe': subscribe,
    'listChanged': listChanged,
  };
}

class McpPromptsCapability {
  final bool listChanged;

  McpPromptsCapability({this.listChanged = false});

  Map<String, dynamic> toJson() => {'listChanged': listChanged};
}

/// MCP Tool Result
class McpToolResult {
  final bool success;
  final dynamic result;
  final String? error;

  McpToolResult({
    required this.success,
    this.result,
    this.error,
  });

  Map<String, dynamic> toJson() => {
    'success': success,
    if (result != null) 'result': result,
    if (error != null) 'error': error,
  };

  factory McpToolResult.fromJson(Map<String, dynamic> json) => McpToolResult(
    success: json['success'] as bool,
    result: json['result'],
    error: json['error'] as String?,
  );
}

/// MCP Resource Content
class McpResourceContent {
  final String uri;
  final String mimeType;
  final String? text;
  final List<int>? blob;

  McpResourceContent({
    required this.uri,
    required this.mimeType,
    this.text,
    this.blob,
  });

  Map<String, dynamic> toJson() => {
    'uri': uri,
    'mimeType': mimeType,
    if (text != null) 'text': text,
    if (blob != null) 'blob': blob,
  };
}

/// MCP Prompt Message
class McpPromptMessage {
  final String role;
  final McpPromptContent content;

  McpPromptMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content.toJson(),
  };
}

/// MCP Prompt Content
abstract class McpPromptContent {
  Map<String, dynamic> toJson();
}

class McpPromptContentText extends McpPromptContent {
  final String text;

  McpPromptContentText(this.text);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'text',
    'text': text,
  };
}

class McpPromptContentResource extends McpPromptContent {
  final McpResourceContent resource;

  McpPromptContentResource(this.resource);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'resource',
    'resource': resource.toJson(),
  };
}