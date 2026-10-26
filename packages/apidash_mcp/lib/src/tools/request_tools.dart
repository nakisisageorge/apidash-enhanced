// Request Management Tools
library apidash_mcp.tools.request_tools;

import 'package:apidash_mcp/models/mcp_models.dart';

abstract class RequestTool extends McpTool {
  RequestTool({
    required super.name,
    required super.description,
    required super.inputSchema,
  });
}

/// Tool to create a new request
class CreateRequestTool extends RequestTool {
  CreateRequestTool() : super(
    name: 'create_request',
    description: 'Create a new API request',
    inputSchema: {
      'type': 'object',
      'properties': {
        'collectionId': {'type': 'string', 'description': 'Collection ID'},
        'folderId': {'type': 'string', 'description': 'Folder ID (optional)'},
        'name': {'type': 'string', 'description': 'Request name'},
        'method': {'type': 'string', 'enum': ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS']},
        'url': {'type': 'string', 'description': 'Request URL'},
        'headers': {'type': 'object', 'description': 'Request headers'},
        'queryParams': {'type': 'object', 'description': 'Query parameters'},
        'body': {'type': 'object', 'description': 'Request body'},
        'bodyType': {'type': 'string', 'enum': ['json', 'form', 'raw', 'binary', 'graphql']},
      },
      'required': ['collectionId', 'name', 'method', 'url'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    // TODO: Implement via apidash_core
    return McpToolResult(
      success: true,
      result: {
        'id': 'req_${DateTime.now().millisecondsSinceEpoch}',
        ...arguments,
        'createdAt': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Tool to send an API request
class SendRequestTool extends RequestTool {
  SendRequestTool() : super(
    name: 'send_request',
    description: 'Send an API request and get response',
    inputSchema: {
      'type': 'object',
      'properties': {
        'requestId': {'type': 'string', 'description': 'Saved request ID (optional)'},
        'method': {'type': 'string', 'enum': ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS']},
        'url': {'type': 'string', 'description': 'Request URL'},
        'headers': {'type': 'object', 'description': 'Request headers'},
        'queryParams': {'type': 'object', 'description': 'Query parameters'},
        'body': {'type': 'object', 'description': 'Request body'},
        'bodyType': {'type': 'string', 'enum': ['json', 'form', 'raw', 'binary', 'graphql']},
        'environmentId': {'type': 'string', 'description': 'Environment ID for variables'},
        'followRedirects': {'type': 'boolean', 'default': true},
        'timeout': {'type': 'integer', 'default': 30000},
      },
      'required': ['method', 'url'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    // TODO: Implement via better_networking
    return McpToolResult(
      success: true,
      result: {
        'statusCode': 200,
        'statusMessage': 'OK',
        'headers': {'content-type': 'application/json'},
        'body': {'message': 'Success', 'data': []},
        'time': 150,
        'size': 1024,
        'requestId': 'req_${DateTime.now().millisecondsSinceEpoch}',
      },
    );
  }
}

/// Tool to get request history
class GetRequestHistoryTool extends RequestTool {
  GetRequestHistoryTool() : super(
    name: 'get_request_history',
    description: 'Get recent API request history',
    inputSchema: {
      'type': 'object',
      'properties': {
        'limit': {'type': 'integer', 'default': 50},
        'offset': {'type': 'integer', 'default': 0},
        'collectionId': {'type': 'string', 'description': 'Filter by collection (optional)'},
      },
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    // TODO: Implement via apidash_core history_service
    return McpToolResult(
      success: true,
      result: {
        'history': [
          {
            'id': 'hist_1',
            'requestId': 'req_1',
            'method': 'POST',
            'url': 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
            'statusCode': 200,
            'time': 1250,
            'timestamp': DateTime.now().subtract(Duration(minutes: 5)).toIso8601String(),
          },
        ],
        'total': 1,
      },
    );
  }
}

/// Tool to save a request to a collection
class SaveRequestToCollectionTool extends RequestTool {
  SaveRequestToCollectionTool() : super(
    name: 'save_request_to_collection',
    description: 'Save an executed request to a collection',
    inputSchema: {
      'type': 'object',
      'properties': {
        'historyId': {'type': 'string', 'description': 'History entry ID'},
        'collectionId': {'type': 'string', 'description': 'Collection ID'},
        'folderId': {'type': 'string', 'description': 'Folder ID (optional)'},
        'name': {'type': 'string', 'description': 'Request name'},
      },
      'required': ['historyId', 'collectionId', 'name'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    // TODO: Implement via apidash_core
    return McpToolResult(
      success: true,
      result: {
        'requestId': 'req_${DateTime.now().millisecondsSinceEpoch}',
        'collectionId': arguments['collectionId'],
        'name': arguments['name'],
        'savedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}