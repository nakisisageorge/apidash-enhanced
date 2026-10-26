// AI-Powered Tools
library apidash_mcp.tools.ai_tools;

import 'package:apidash_mcp/models/mcp_models.dart';

abstract class AiTool extends McpTool {
  AiTool({
    required super.name,
    required super.description,
    required super.inputSchema,
  });
}

/// Tool to generate API requests using AI
class AiGenerateRequestTool extends AiTool {
  AiGenerateRequestTool() : super(
    name: 'ai_generate_request',
    description: 'Generate an API request from natural language using AI',
    inputSchema: {
      'type': 'object',
      'properties': {
        'prompt': {'type': 'string', 'description': 'Natural language description of the API request'},
        'context': {'type': 'string', 'description': 'Additional context (API docs, existing requests, etc.)'},
        'provider': {'type': 'string', 'enum': ['openai', 'anthropic', 'google', 'local', 'auto'], 'default': 'auto'},
        'model': {'type': 'string', 'description': 'Specific model to use (optional)'},
        'collectionId': {'type': 'string', 'description': 'Collection to save the request to (optional)'},
      },
      'required': ['prompt'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    final prompt = arguments['prompt'] as String;
    final context = arguments['context'] as String?;
    final provider = arguments['provider'] as String? ?? 'auto';
    final model = arguments['model'] as String?;
    final collectionId = arguments['collectionId'] as String?;

    // TODO: Implement via genai package and DashBot
    return McpToolResult(
      success: true,
      result: {
        'request': {
          'id': 'req_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'AI Generated Request',
          'method': 'POST',
          'url': 'https://api.example.com/generated',
          'headers': {'Content-Type': 'application/json'},
          'body': {'generated': true, 'prompt': prompt},
        },
        'collectionId': collectionId,
        'provider': provider,
        'model': model,
        'generatedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Tool to explain API response using AI
class AiExplainResponseTool extends AiTool {
  AiExplainResponseTool() : super(
    name: 'ai_explain_response',
    description: 'Explain an API response in plain language using AI',
    inputSchema: {
      'type': 'object',
      'properties': {
        'response': {'type': 'object', 'description': 'API response to explain'},
        'request': {'type': 'object', 'description': 'Original request (optional)'},
        'detailLevel': {'type': 'string', 'enum': ['summary', 'detailed', 'technical'], 'default': 'detailed'},
        'provider': {'type': 'string', 'enum': ['openai', 'anthropic', 'google', 'local', 'auto'], 'default': 'auto'},
      },
      'required': ['response'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    final response = arguments['response'] as Map<String, dynamic>;
    final request = arguments['request'] as Map<String, dynamic>?;
    final detailLevel = arguments['detailLevel'] as String? ?? 'detailed';
    final provider = arguments['provider'] as String? ?? 'auto';

    // TODO: Implement via genai package and DashBot prompts
    return McpToolResult(
      success: true,
      result: {
        'explanation': 'This API response returns a list of mobile money transactions. The status code 200 indicates success. The response body contains an array of transaction objects with fields: id, amount, currency, timestamp, status, and recipient.',
        'detailLevel': detailLevel,
        'provider': provider,
        'generatedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Tool to debug API request using AI
class AiDebugRequestTool extends AiTool {
  AiDebugRequestTool() : super(
    name: 'ai_debug_request',
    description: 'Debug an API request/response using AI analysis',
    inputSchema: {
      'type': 'object',
      'properties': {
        'request': {'type': 'object', 'description': 'Request that failed'},
        'response': {'type': 'object', 'description': 'Error response received'},
        'error': {'type': 'string', 'description': 'Error message (optional)'},
        'provider': {'type': 'string', 'enum': ['openai', 'anthropic', 'google', 'local', 'auto'], 'default': 'auto'},
      },
      'required': ['request', 'response'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    final request = arguments['request'] as Map<String, dynamic>;
    final response = arguments['response'] as Map<String, dynamic>;
    final error = arguments['error'] as String?;
    final provider = arguments['provider'] as String? ?? 'auto';

    // TODO: Implement via genai package and DashBot debug prompts
    return McpToolResult(
      success: true,
      result: {
        'analysis': 'The request failed with a 401 Unauthorized error. This typically indicates an invalid or expired authentication token. Check that your API key is valid and has the necessary permissions.',
        'suggestions': [
          'Verify the API key is correct and not expired',
          'Check if the API key has the required scopes/permissions',
          'Ensure the Authorization header is properly formatted',
          'Try regenerating the API key from the provider dashboard',
        ],
        'provider': provider,
        'generatedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Tool to generate test cases using AI
class AiGenerateTestsTool extends AiTool {
  AiGenerateTestsTool() : super(
    name: 'ai_generate_tests',
    description: 'Generate test cases for an API endpoint using AI',
    inputSchema: {
      'type': 'object',
      'properties': {
        'spec': {'type': 'string', 'description': 'OpenAPI spec, request example, or endpoint description'},
        'language': {'type': 'string', 'enum': ['python', 'javascript', 'typescript', 'dart', 'java', 'go', 'rust'], 'default': 'python'},
        'framework': {'type': 'string', 'description': 'Test framework (e.g., pytest, jest, vitest, flutter_test, junit)'},
        'testTypes': {'type': 'array', 'items': {'type': 'string', 'enum': ['unit', 'integration', 'contract', 'performance', 'security']}, 'default': ['unit', 'integration']},
        'provider': {'type': 'string', 'enum': ['openai', 'anthropic', 'google', 'local', 'auto'], 'default': 'auto'},
      },
      'required': ['spec'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    final spec = arguments['spec'] as String;
    final language = arguments['language'] as String? ?? 'python';
    final framework = arguments['framework'] as String?;
    final testTypes = arguments['testTypes'] as List<dynamic>? ?? ['unit', 'integration'];
    final provider = arguments['provider'] as String? ?? 'auto';

    // TODO: Implement via genai package and DashBot codegen prompts
    return McpToolResult(
      success: true,
      result: {
        'tests': _generateSampleTests(language, framework, testTypes),
        'language': language,
        'framework': framework,
        'testTypes': testTypes,
        'provider': provider,
        'generatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  String _generateSampleTests(String language, String? framework, List<dynamic> testTypes) {
    if (language == 'python') {
      return '''# Generated by API Dash MCP Server
import pytest
import requests

BASE_URL = "https://api.example.com"

def test_get_endpoint_success():
    response = requests.get(f"{BASE_URL}/endpoint")
    assert response.status_code == 200
    assert "data" in response.json()

def test_get_endpoint_not_found():
    response = requests.get(f"{BASE_URL}/endpoint/999")
    assert response.status_code == 404

def test_post_endpoint_validation():
    response = requests.post(f"{BASE_URL}/endpoint", json={})
    assert response.status_code == 400
    assert "error" in response.json()''';
    } else if (language == 'javascript') {
      return '''// Generated by API Dash MCP Server
const axios = require('axios');

const BASE_URL = 'https://api.example.com';

describe('API Endpoint Tests', () => {
  test('GET /endpoint - success', async () => {
    const response = await axios.get(\`\${BASE_URL}/endpoint\`);
    expect(response.status).toBe(200);
    expect(response.data).toHaveProperty('data');
  });

  test('GET /endpoint/999 - not found', async () => {
    try {
      await axios.get(\`\${BASE_URL}/endpoint/999\`);
    } catch (error) {
      expect(error.response.status).toBe(404);
    }
  });
});''';
    } else if (language == 'dart') {
      return '''// Generated by API Dash MCP Server
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  const baseUrl = 'https://api.example.com';

  group('API Endpoint Tests', () {
    test('GET /endpoint - success', () async {
      final response = await http.get(Uri.parse('\$baseUrl/endpoint'));
      expect(response.statusCode, 200);
      expect(response.body, contains('data'));
    });

    test('GET /endpoint/999 - not found', () async {
      final response = await http.get(Uri.parse('\$baseUrl/endpoint/999'));
      expect(response.statusCode, 404);
    });
  });
}''';
    }
    return '// Tests for $language not implemented yet';
  }
}

/// Tool to generate documentation using AI
class AiGenerateDocumentationTool extends AiTool {
  AiGenerateDocumentationTool() : super(
    name: 'ai_generate_documentation',
    description: 'Generate API documentation from requests using AI',
    inputSchema: {
      'type': 'object',
      'properties': {
        'collectionId': {'type': 'string', 'description': 'Collection ID to document'},
        'format': {'type': 'string', 'enum': ['markdown', 'html', 'openapi', 'postman'], 'default': 'markdown'},
        'includeExamples': {'type': 'boolean', 'default': true},
        'includeCodeSamples': {'type': 'boolean', 'default': true},
        'languages': {'type': 'array', 'items': {'type': 'string'}, 'default': ['cURL', 'Python', 'JavaScript']},
        'provider': {'type': 'string', 'enum': ['openai', 'anthropic', 'google', 'local', 'auto'], 'default': 'auto'},
      },
      'required': ['collectionId'],
    },
  );

  @override
  Future<McpToolResult> execute(Map<String, dynamic> arguments) async {
    final collectionId = arguments['collectionId'] as String;
    final format = arguments['format'] as String? ?? 'markdown';
    final includeExamples = arguments['includeExamples'] as bool? ?? true;
    final includeCodeSamples = arguments['includeCodeSamples'] as bool? ?? true;
    final languages = arguments['languages'] as List<dynamic>? ?? ['cURL', 'Python', 'JavaScript'];
    final provider = arguments['provider'] as String? ?? 'auto';

    // TODO: Implement via genai package and DashBot documentation prompts
    return McpToolResult(
      success: true,
      result: {
        'collectionId': collectionId,
        'format': format,
        'documentation': '# API Documentation\n\nGenerated by API Dash MCP Server\n\n## Endpoints\n\n### POST /mpesa/stkpush\nInitiate M-Pesa STK Push payment...',
        'includeExamples': includeExamples,
        'includeCodeSamples': includeCodeSamples,
        'languages': languages,
        'provider': provider,
        'generatedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}