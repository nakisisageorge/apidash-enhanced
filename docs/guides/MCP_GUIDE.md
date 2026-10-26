# MCP Server Guide

Complete guide to setting up and using the API Dash Enhanced MCP (Model Context Protocol) server.

## Overview

The MCP server exposes API Dash functionality to AI coding agents (Claude, Cursor, Codex, etc.) via the Model Context Protocol. It provides 10 tools across 6 categories.

## Quick Start

### Option 1: Claude Desktop (stdio)

1. **Build the MCP server**:
```bash
cd apidash-enhanced
flutter build linux --release  # or macos/windows
```

2. **Configure Claude Desktop**:
```json
// macOS: ~/Library/Application Support/Claude/claude_desktop_config.json
// Windows: %APPDATA%\Claude\claude_desktop_config.json
// Linux: ~/.config/Claude/claude_desktop_config.json

{
  "mcpServers": {
    "apidash": {
      "command": "/path/to/apidash-enhanced/build/linux/x64/release/bundle/apidash",
      "args": ["--mcp-stdio"],
      "cwd": "/path/to/apidash-enhanced"
    }
  }
}
```

3. **Restart Claude Desktop** — the server will auto-start

### Option 2: HTTP/SSE (Cursor, Codex, Web Agents)

1. **Start the HTTP server**:
```bash
cd apidash-enhanced
flutter run -d web --dart-define=MCP_HTTP=true --dart-define=MCP_PORT=3000
```

2. **Configure your agent**:
- **URL**: `http://localhost:3000/mcp`
- **Auth**: `Bearer <API_KEY>` (set `APIDASH_MCP_API_KEY` env var)
- **CORS**: Enabled for localhost

### Option 3: Docker (Recommended for Production)

```dockerfile
# Dockerfile.mcp
FROM ghcr.io/nakisisageorge/apidash-enhanced:mcp-latest
EXPOSE 3000
ENV APIDASH_MCP_API_KEY=your-secure-key
CMD ["--mcp-http", "--port=3000"]
```

```bash
docker build -f Dockerfile.mcp -t apidash-mcp .
docker run -p 3000:3000 -e APIDASH_MCP_API_KEY=your-key apidash-mcp
```

## Available Tools

### Collection Management (3 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `create_collection` | Create new collection | `name` (req), `description`, `folderId` |
| `list_collections` | List all collections | `folderId` (opt) |
| `get_collection` | Get collection with requests | `collectionId` (req) |
| `update_collection` | Update collection | `collectionId` (req), `name`, `description` |
| `delete_collection` | Delete collection | `collectionId` (req) |
| `create_folder` | Create folder in collection | `collectionId` (req), `name` (req), `parentId` |
| `delete_folder` | Delete folder | `folderId` (req) |

### Request Management (4 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `create_request` | Create new request | `collectionId`, `name`, `method`, `url`, `headers`, `body`, `bodyType` |
| `send_request` | Execute request | `requestId` OR `method`+`url`+`headers`+`body`, `environmentId` |
| `get_request_history` | Get recent history | `limit`, `offset`, `collectionId` |
| `save_request_to_collection` | Save executed request | `historyId`, `collectionId`, `name`, `folderId` |

### Code Generation (2 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `generate_code` | Generate integration code | `requestId` (req), `language` (req), `library`, `includeAuth`, `includeErrorHandling`, `async` |
| `list_supported_languages` | List all languages | (none) |

**Supported Languages**: cURL, Dart, Python, JavaScript, TypeScript, Java, Kotlin, Swift, Go, Rust, C#, PHP, Ruby, Node.js, PowerShell, R, MATLAB, Julia, Scala, Groovy

### Import/Export (6 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `import_collection` | Import from file/URL | `format` (postman/insomnia/har/openapi/curl/apidash), `source`, `collectionName`, `overwrite` |
| `export_collection` | Export to format | `collectionId` (req), `format`, `outputPath`, `includeEnvironments` |
| `import_from_curl` | Import from cURL | `curlCommand` (req), `collectionId`, `requestName` |
| `import_from_postman` | Import Postman | `source` (req), `collectionName` |
| `import_from_insomnia` | Import Insomnia | `source` (req), `collectionName` |
| `import_from_har` | Import HAR | `source` (req), `collectionName`, `filterDomain` |
| `import_from_openapi` | Import OpenAPI | `source` (req), `collectionName`, `includeExamples`, `serverIndex` |

### AI Workflows (5 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `ai_generate_request` | Natural language → request | `prompt` (req), `context`, `provider`, `model`, `collectionId` |
| `ai_explain_response` | Explain response | `response` (req), `request`, `detailLevel`, `provider` |
| `ai_debug_request` | Debug failed request | `request` (req), `response` (req), `error`, `provider` |
| `ai_generate_tests` | Generate test cases | `spec` (req), `language`, `framework`, `testTypes`, `provider` |
| `ai_generate_documentation` | Generate docs | `collectionId` (req), `format`, `includeExamples`, `includeCodeSamples`, `languages`, `provider` |

### Environment Management (5 tools)

| Tool | Description | Parameters |
|------|-------------|------------|
| `create_environment` | Create environment | `name` (req), `variables`, `description` |
| `list_environments` | List environments | (none) |
| `update_environment` | Update environment | `environmentId` (req), `name`, `variables`, `description` |
| `delete_environment` | Delete environment | `environmentId` (req) |
| `set_active_environment` | Activate environment | `environmentId` (req) |

## Authentication

### API Key Setup
```bash
export APIDASH_MCP_API_KEY="your-secure-random-key"
```

### Token Management
- Tokens auto-generated on first request
- Expiry: 24 hours (configurable)
- Stored in memory, cleaned up automatically

### CORS Configuration
Default allowed origins:
- `http://localhost:3000`
- `http://127.0.0.1:3000`

Customize via `AuthConfig.allowedOrigins`.

## Resources

The server exposes 4 resources:

| URI | Description |
|-----|-------------|
| `apidash://collections` | All collections with requests |
| `apidash://environments` | All environments with variables |
| `apidash://history` | Recent request history |
| `apidash://supported-languages` | Code generation languages |

## Prompts

Pre-built prompts for common workflows:

| Prompt | Description | Arguments |
|--------|-------------|-----------|
| `create-api-request` | Create request with best practices | `method` (req), `url` (req), `auth` (opt) |
| `debug-api-error` | Debug error response | `response` (req), `request` (opt) |
| `generate-api-tests` | Generate test cases | `spec` (req), `language` (opt) |

## Example Usage

### Generate M-Pesa STK Push Request
```json
{
  "tool": "ai_generate_request",
  "arguments": {
    "prompt": "Create M-Pesa STK Push for phone 254712345678, amount 1000 KES, account reference ORDER123",
    "provider": "auto",
    "collectionId": "m_pesa_kenya"
  }
}
```

### Debug Failed Payment
```json
{
  "tool": "ai_debug_request",
  "arguments": {
    "request": { "method": "POST", "url": "https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest", ... },
    "response": { "statusCode": 401, "body": "Invalid token" },
    "error": "401 Unauthorized"
  }
}
```

### Generate Python Tests for Flutterwave
```json
{
  "tool": "ai_generate_tests",
  "arguments": {
    "spec": "POST /v3/payments with amount, currency, email, phone",
    "language": "python",
    "framework": "pytest",
    "testTypes": ["unit", "integration"]
  }
}
```

## Configuration

### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `APIDASH_MCP_API_KEY` | Enable auth + set key | (disabled) |
| `APIDASH_MCP_HTTP` | Enable HTTP server | false |
| `APIDASH_MCP_PORT` | HTTP port | 3000 |
| `APIDASH_MCP_HOST` | HTTP host | 127.0.0.1 |
| `APIDASH_MCP_DATA_DIR` | Data directory | ~/.apidash/mcp |

### Command Line Flags
```bash
apidash --mcp-stdio           # stdio transport
apidash --mcp-http            # HTTP/SSE transport
apidash --mcp-http --port=3000 # Custom port
apidash --data-dir=/path      # Custom data directory
```

## Troubleshooting

### Server Won't Start
- Check Flutter version: `flutter --version` (needs 3.24+)
- Check dependencies: `melos bootstrap`
- Check port conflicts: `lsof -i :3000`

### Authentication Fails
- Verify `APIDASH_MCP_API_KEY` is set
- Check token expiry (24h default)
- Verify CORS origins include your agent's origin

### Tools Not Found
- Restart agent after config changes
- Check MCP server logs for errors
- Verify server is registered in agent config

### Performance Issues
- Increase `config.iterations` for benchmarks
- Use `config.warmupIterations` for JIT warmup
- Monitor memory with `config.measureMemory=true`

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on adding new tools or improving existing ones.

## Support

- **Issues**: [GitHub Issues](https://github.com/nakisisageorge/apidash-enhanced/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nakisisageorge/apidash-enhanced/discussions)
- **Email**: nakisisageorge@gmail.com