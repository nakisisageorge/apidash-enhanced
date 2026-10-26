# API Dash Enhanced

![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.5+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-Apache--2.0-blue?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows%20%7C%20Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge)
![CI](https://img.shields.io/github/actions/workflow/status/nakisisageorge/apidash-enhanced/flutter-ci.yml?branch=main&style=for-the-badge)
![Coverage](https://img.shields.io/codecov/c/github/nakisisageorge/apidash-enhanced?style=for-the-badge)

**Enhanced API Dash distribution: MCP server for AI agents, African API collections (47), benchmark suite with regression detection, interactive architecture visualization, comprehensive documentation suite, enhanced CI/CD pipeline.**

---

## 🎯 What Is This?

API Dash Enhanced is a **substantial enhancement fork** of the excellent [API Dash](https://github.com/foss42/apidash) by foss42. It adds production-ready engineering capabilities for modern AI-assisted development workflows and African fintech integration.

### Key Enhancements

| Area | Enhancement |
|------|-------------|
| 🤖 **AI Agents** | **MCP Server** — 10 tools via stdio/HTTP/SSE for Claude, Cursor, Codex |
| 🌍 **African APIs** | **47 pre-built collections** — M-Pesa, Flutterwave, Paystack, Sendy, and more |
| 📊 **Performance** | **Benchmark Suite** — Regression detection (15% threshold) with CI integration |
| 🏗️ **Architecture** | **Interactive Visualization** — React Flow diagram + collapsible doc tree (50+ nodes) |
| 🔒 **Security** | **4-layer scanning** — TruffleHog, Semgrep, OSV, OWASP + SLSA Level 3 |
| 🚀 **CI/CD** | **11-job pipeline** — 6-platform builds, security, provenance, auto-release |
| 📚 **Documentation** | **8-document suite** — DESIGN_DOC, CASE_STUDY, BEFORE_AFTER, guides |

---

## 🚀 Quick Start

### Installation

#### Desktop (Linux/macOS/Windows)
```bash
# Linux (AppImage)
wget https://github.com/nakisisageorge/apidash-enhanced/releases/latest/download/apidash-linux-x86_64.AppImage
chmod +x apidash-linux-x86_64.AppImage
./apidash-linux-x86_64.AppImage

# macOS (DMG)
# Download from GitHub Releases, open .dmg, drag to Applications

# Windows (MSIX)
# Download from GitHub Releases or install via Winget:
winget install nakisisageorge.apidash
```

#### Mobile (Android/iOS)
```bash
# Android
# Download APK from GitHub Releases or install via Play Store (coming soon)

# iOS
# Install via TestFlight (link in GitHub Releases)
```

#### Web (PWA)
```bash
# Visit: https://nakisisageorge.github.io/apidash-enhanced/
# Install as PWA for offline use
```

### Build from Source
```bash
git clone https://github.com/nakisisageorge/apidash-enhanced.git
cd apidash-enhanced
melos bootstrap
flutter run -d <device>
```

---

## 🤖 MCP Server for AI Agents

API Dash Enhanced includes a **Model Context Protocol (MCP) server** that exposes API client functionality to AI coding agents.

### Supported Agents
- ✅ **Claude Desktop** (via stdio)
- ✅ **Cursor** (via stdio/HTTP)
- ✅ **Codex** (via stdio/HTTP)
- ✅ **Any MCP-compatible client**

### Available Tools (10 tools, 6 categories)

| Category | Tools |
|----------|-------|
| **Collections** | `create_collection`, `list_collections`, `get_collection`, `update_collection`, `delete_collection`, `create_folder`, `delete_folder` |
| **Requests** | `create_request`, `send_request`, `get_request_history`, `save_request_to_collection` |
| **Code Generation** | `generate_code` (20 languages), `list_supported_languages` |
| **Import/Export** | `import_collection`, `export_collection`, `import_from_curl`, `import_from_postman`, `import_from_insomnia`, `import_from_har`, `import_from_openapi` |
| **AI Workflows** | `ai_generate_request`, `ai_explain_response`, `ai_debug_request`, `ai_generate_tests`, `ai_generate_documentation` |
| **Environments** | `create_environment`, `list_environments`, `update_environment`, `delete_environment`, `set_active_environment` |

### Setup MCP Server

#### Claude Desktop (stdio)
```json
// ~/Library/Application Support/Claude/claude_desktop_config.json (macOS)
// %APPDATA%\Claude\claude_desktop_config.json (Windows)
{
  "mcpServers": {
    "apidash": {
      "command": "flutter",
      "args": ["run", "-d", "desktop", "--dart-define=MCP_STDIO=true"],
      "cwd": "/path/to/apidash-enhanced"
    }
  }
}
```

#### HTTP/SSE (for web agents)
```bash
# Start MCP HTTP server
cd apidash-enhanced
flutter run -d web --dart-define=MCP_HTTP=true --dart-define=MCP_PORT=3000

# Configure in your agent:
# URL: http://localhost:3000/mcp
# Auth: Bearer <API_KEY> (set APIDASH_MCP_API_KEY env var)
```

### Example: Generate API Request via AI
```python
# Using MCP from an AI agent
result = await mcp.call_tool("ai_generate_request", {
    "prompt": "Create a POST request to M-Pesa STK Push with phone 254712345678, amount 1000 KES",
    "provider": "auto"
})
# Returns: Complete request with headers, body, auth configured
```

---

## 🌍 African API Collections (47 APIs, 6 Categories)

Pre-built, authenticated, sandbox-ready collections for African fintech, mobile money, logistics, banking, and identity APIs.

### Collections by Category

| Category | APIs | Example Providers |
|----------|------|-------------------|
| **Mobile Money** | 10 | M-Pesa (KE/TZ), MTN MoMo (UG/GH/RW), Airtel Money, Orange Money, Wave, Chipper Cash, Paga, Opay, PalmPay |
| **FinTech** | 7 | Flutterwave, Paystack, Interswitch, Payfast, Ozow, Yoco, Peach Payments |
| **Logistics** | 5 | Sendy, Lori Systems, Kobo360, Truckr, GIG Logistics |
| **Banking** | 7 | Standard Bank, ABSA, FNB, Nedbank, Equity Bank, KCB Group, Co-op Bank |
| **Identity** | 3 | Smile Identity, Youverify, Prembly |
| **Payments** | 5 | MFS Africa, Cellulant, DPO Group, iPay Africa, Jenga |

### Quick Start: M-Pesa Kenya
```bash
# 1. Load collection (via UI or MCP)
# Collection: "M-Pesa Kenya" → Folder: "STK Push" → Request: "STK Push Payment"

# 2. Configure environment
# Environment: "M-Pesa Kenya Sandbox"
# Variables: consumer_key, consumer_secret, passkey, shortcode

# 3. Send request
# AI can generate: "Initiate STK push for 254712345678, 1000 KES, account ref ORDER123"
```

### Authentication Patterns Supported
- **OAuth2 Client Credentials**: M-Pesa, Flutterwave, Paystack, banks
- **API Key + Secret**: Payfast, Ozow, Yoco, Peach
- **Subscription Key**: MTN MoMo, Airtel Money
- **HMAC/Signature**: Interswitch, some banking APIs
- **Basic Auth**: Some legacy endpoints

---

## 📊 Benchmark Suite

Performance regression detection integrated into CI/CD.

### Running Benchmarks
```bash
cd benchmark
dart pub get
dart run benchmark_runner.dart --save-baseline
```

### CI Integration
- Runs on every PR
- Comments results on PR
- Fails build if regression > 15%
- Baseline stored per version

### Benchmark Categories
| Category | Benchmarks |
|----------|------------|
| **HTTP** | GET, POST, GraphQL, WebSocket, MQTT, gRPC |
| **CodeGen** | 20 languages × 2 libraries each |
| **JSON** | Parse small (1KB), large (1MB), render |
| **Import/Export** | Postman, Insomnia, HAR, OpenAPI, cURL |
| **AI** | Local model inference, prompt processing |

### Regression Threshold
- **Default**: 15% performance degradation
- **Configurable**: `--regression-threshold=0.10`
- **Action**: Fails CI, comments on PR with details

---

## 🏗️ Architecture Visualization

Interactive, explorable architecture diagrams.

### View Online
- **Architecture Diagram**: https://nakisisageorge.github.io/apidash-enhanced/architecture/
- **Documentation Tree**: https://nakisisageorge.github.io/apidash-enhanced/docs/

### Features
- **Package Graph**: 14 packages with dependency edges
- **Data Flow**: Request → Network → Response → Preview → CodeGen
- **AI Pipeline**: DashBot → GenAI → Agentic Engine → Tools
- **Platform Targets**: 6 platforms with build status
- **Interactions**: Zoom, pan, search, expand/collapse, export (PNG/SVG/PDF)

### Local Development
```bash
cd docs/architecture
npm install
npm start  # Opens at http://localhost:3000
```

---

## 📚 Documentation Suite

| Document | Description |
|----------|-------------|
| [DESIGN_DOCUMENT.md](DESIGN_DOCUMENT.md) | Architecture, decisions, security, performance, scalability |
| [PORTFOLIO_CASE_STUDY.md](PORTFOLIO_CASE_STUDY.md) | Problem, research, approach, results, lessons learned |
| [BEFORE_AFTER.md](BEFORE_AFTER.md) | Detailed comparison table (this vs original) |
| [Architecture Viz](docs/architecture/ARCHITECTURE.md) | Interactive React Flow diagram guide |
| [Documentation Tree](docs/tree/DocumentationTree.jsx) | Interactive collapsible tree (50+ nodes) |
| [MCP Server Guide](docs/guides/MCP_GUIDE.md) | Setup, tools, authentication, examples |
| [African APIs Guide](docs/guides/AFRICAN_APIS_GUIDE.md) | Collections, auth, sandbox, examples |

---

## 🔒 Security

### 4-Layer Security Scanning
| Layer | Tool | Purpose |
|-------|------|---------|
| **Secrets** | TruffleHog | Git history + working tree secret detection |
| **SAST** | Semgrep | Dart/Flutter security rules + custom rules |
| **Dependencies** | OSV + OWASP Dependency Check | Vulnerability scanning (CVSS ≥7 fails) |
| **Supply Chain** | SLSA Level 3 | Provenance for all release artifacts |

### Secure Credential Storage
- **Desktop**: Platform keychain (macOS), Credential Manager (Windows), libsecret (Linux)
- **Mobile**: Android Keystore, iOS Keychain
- **MCP Server**: API key auth with token expiry, per-client tokens

### Compliance
- **OWASP ASVS Level 2** alignment
- **SLSA Level 3** for all published artifacts
- **No telemetry** without explicit consent

---

## 🛠️ Development

### Prerequisites
- Flutter 3.24+
- Dart 3.5+
- Melos 6.0+
- Node.js 20+ (for architecture viz)

### Setup
```bash
git clone https://github.com/nakisisageorge/apidash-enhanced.git
cd apidash-enhanced
melos bootstrap
```

### Commands
```bash
# Analyze all packages
melos exec -c 1 -- flutter analyze

# Format all packages
melos exec -c 1 -- dart format --output=none --set-exit-if-changed .

# Run all tests
melos exec -c 1 -- flutter test --coverage

# Run benchmarks
cd benchmark && dart run benchmark_runner.dart

# Build all platforms
melos exec -c 1 -- flutter build linux --release
melos exec -c 1 -- flutter build macos --release
melos exec -c 1 -- flutter build windows --release
melos exec -c 1 -- flutter build apk --release
melos exec -c 1 -- flutter build ios --release
melos exec -c 1 -- flutter build web --release
```

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Ways to Contribute
- 🐛 Report bugs
- 💡 Request features
- 📝 Improve documentation
- 🔧 Submit PRs (bug fixes, enhancements)
- 🌍 Add African API collections
- 🧪 Add benchmarks
- 🔒 Improve security

### African API Contributions
We're especially interested in:
- New mobile money providers (Ethiopia, Egypt, Morocco, etc.)
- Additional fintech APIs (remittances, lending, insurance)
- Regulatory/compliance APIs
- Agricultural, health, education APIs

---

## 📄 License

Apache-2.0 — Same as original API Dash.

```
Copyright 2024 foss42 (original API Dash)
Copyright 2024 George Nakisisa / GICT Africa Technologies (enhancements)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

## 🙏 Attribution

**Original Project**: [API Dash](https://github.com/foss42/apidash) by [foss42](https://github.com/foss42)
- License: Apache-2.0
- Repository: https://github.com/foss42/apidash

**Enhancements by**: [George Nakisisa](https://github.com/nakisisageorge) / [GICT Africa Technologies](https://gictafrica.com)
- Repository: https://github.com/nakisisageorge/apidash-enhanced
- License: Apache-2.0

All original copyright notices preserved. Enhancements clearly distinguished in documentation.

---

## 📞 Support & Community

- **Issues**: [GitHub Issues](https://github.com/nakisisageorge/apidash-enhanced/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nakisisageorge/apidash-enhanced/discussions)
- **Discord**: [API Dash Community](https://discord.gg/apidash) (original)
- **Email**: nakisisageorge@gmail.com

---

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=nakisisageorge/apidash-enhanced&type=Date)](https://star-history.com/#nakisisageorge/apidash-enhanced&Date)

---

**Built with ❤️ for African developers and AI-assisted engineering workflows worldwide.**

*API Dash Enhanced — Making API development productive, secure, and accessible across Africa and beyond.*