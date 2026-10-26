# DESIGN_DOCUMENT.md

# API Dash Enhanced — Design Document

## 1. Original Architecture

API Dash (foss42/apidash) is a Flutter/Dart cross-platform API client with a modular multi-package architecture:

### Original Package Structure (11 packages)
```
apidash/
├── packages/
│   ├── apidash_core          # Core models, services, utilities
│   ├── apidash_design_system # Reusable UI components
│   ├── better_networking     # HTTP/WebSocket/gRPC/MQTT
│   ├── curl_parser           # cURL command parsing
│   ├── genai                 # Multi-provider AI integration
│   ├── har                   # HAR import/export
│   ├── insomnia_collection   # Insomnia import
│   ├── json_explorer         # JSON visualization
│   ├── json_field_editor     # JSON editing
│   ├── multi_trigger_autocomplete_plus # Smart autocomplete
│   ├── postman               # Postman import
│   └── seed                  # Seed data
└── lib/                      # Main application
    ├── dashbot/              # AI assistant (30+ prompts)
    ├── models/               # Request/response models
    ├── screens/              # UI screens
    ├── services/             # Business logic services
    └── widgets/              # Custom widgets
```

### Original Capabilities
- **API Types**: HTTP, GraphQL, SSE, WebSocket, MQTT, gRPC
- **Authentication**: OAuth2, API Keys, Basic Auth, Bearer Tokens
- **Code Generation**: 20+ languages (cURL, Dart, Python, JS, Java, Go, Rust, etc.)
- **Import/Export**: Postman, Insomnia, HAR, OpenAPI, cURL
- **AI Assistant (DashBot)**: 30+ prompt types for codegen, debugging, documentation
- **Platforms**: Desktop (Linux, macOS, Windows), Mobile (Android, iOS)

### Original Technology Stack
- **Framework**: Flutter 3.x / Dart 3.x
- **State Management**: Provider
- **Local Storage**: Hive + SharedPreferences
- **Networking**: Custom `better_networking` package
- **AI**: Multi-provider via `genai` package (OpenAI, Anthropic, Google, local)
- **Code Gen**: Template-based with `code_builder`
- **Testing**: flutter_test + integration_test

---

## 2. Problems Identified

### 2.1 No AI Agent Integration (MCP)
- **Problem**: API Dash cannot be used by AI agents (Claude, Cursor, Codex, etc.)
- **Impact**: Developers using AI coding assistants cannot leverage API Dash's capabilities programmatically
- **Gap**: Model Context Protocol (MCP) server missing

### 2.2 No African API Ecosystem Support
- **Problem**: Zero pre-built collections for African fintech/mobile money/logistics APIs
- **Impact**: African developers must manually configure 47+ API endpoints
- **Gap**: Mobile money (M-Pesa, MoMo, Airtel, Orange, Wave), FinTech (Flutterwave, Paystack), Logistics, Banking, Identity

### 2.3 Limited CI/CD Pipeline
- **Problem**: Only AUR publishing, scorecard, and semgrep workflows
- **Impact**: No automated testing, building, or deployment for Flutter platforms
- **Gap**: No multi-platform builds, no benchmark regression, no security scanning

### 2.4 No Performance Benchmarking
- **Problem**: No way to detect performance regressions
- **Impact**: Code changes may introduce latency/memory issues undetected
- **Gap**: Benchmark suite with regression detection

### 2.5 No Architecture Visualization
- **Problem**: No interactive documentation of package relationships
- **Impact**: New contributors struggle to understand the 11-package architecture
- **Gap**: Interactive architecture diagram

### 2.6 Security Gaps
- **Problem**: No secret scanning, dependency vulnerability monitoring, or secure credential storage
- **Impact**: Potential credential leaks, unpatched vulnerabilities
- **Gap**: Security scanning in CI, encrypted storage

---

## 3. Proposed Architecture

### 3.1 Enhanced Package Structure (14 packages)
```
apidash-enhanced/
├── packages/
│   ├── apidash_core           # Core models, services, utilities
│   ├── apidash_design_system  # Reusable UI components
│   ├── better_networking      # HTTP/WebSocket/gRPC/MQTT
│   ├── curl_parser            # cURL command parsing
│   ├── genai                  # Multi-provider AI integration
│   ├── har                    # HAR import/export
│   ├── insomnia_collection    # Insomnia import
│   ├── json_explorer          # JSON visualization
│   ├── json_field_editor      # JSON editing
│   ├── multi_trigger_autocomplete_plus # Smart autocomplete
│   ├── postman                # Postman import
│   ├── seed                   # Seed data
│   ├── apidash_mcp            # NEW: MCP Server for AI agents
│   └── apidash_african_apis   # NEW: African API collections
└── lib/                       # Main application
    ├── dashbot/               # AI assistant (30+ prompts)
    ├── models/                # Request/response models
    ├── screens/               # UI screens
    ├── services/              # Business logic services
    └── widgets/               # Custom widgets
benchmark/                     # NEW: Benchmark suite
docs/
├── architecture/              # Architecture visualization
├── tree/                      # Interactive documentation tree
└── screenshots/               # Visual documentation
```

### 3.2 New Components

#### MCP Server Package (`apidash_mcp`)
- **Tools**: 10 tools across 6 categories
  - Collection Management (3): create, list, get, update, delete collections/folders
  - Request Management (4): create, send, history, save requests
  - Code Generation (2): generate code (20 langs), list languages
  - Import/Export (6): Postman, Insomnia, HAR, OpenAPI, cURL import/export
  - AI Tools (5): generate request, explain response, debug, generate tests, generate docs
  - Environment Management (5): create, list, update, delete, activate environments
- **Transports**: stdio (Claude Desktop), HTTP/SSE (web), WebSocket (real-time)
- **Authentication**: API key based, token expiry, CORS support
- **Resources**: Collections, Environments, History, Supported Languages

#### African API Collections Package (`apidash_african_apis`)
- **47 pre-built API collections** across 6 categories:
  - Mobile Money (10): M-Pesa Kenya/TZ, MTN MoMo, Airtel Money, Orange Money, Wave, Chipper Cash, Paga, Opay, PalmPay
  - FinTech (7): Flutterwave, Paystack, Interswitch, Payfast, Ozow, Yoco, Peach Payments
  - Logistics (5): Sendy, Lori Systems, Kobo360, Truckr, GIG Logistics
  - Banking (7): Standard Bank, ABSA, FNB, Nedbank, Equity, KCB, Co-op Bank
  - Identity (3): Smile Identity, Youverify, Prembly
  - Payments (5): MFS Africa, Cellulant, DPO Group, iPay Africa, Jenga
- **Pre-configured environments** for all sandbox/production endpoints
- **Authentication helpers** for OAuth2, API keys, subscription keys

#### Benchmark Suite (`benchmark/`)
- **Categories**: HTTP requests, Code generation, JSON parsing, Import/Export, AI processing
- **Metrics**: Latency (mean/median/p95/p99), Memory, Throughput
- **Regression Detection**: 15% threshold with baseline comparison
- **CI Integration**: PR comments with benchmark results

---

## 4. Technology Decisions

### 4.1 Flutter/Dart (Continued)
- **Rationale**: Original choice proven; cross-platform single codebase
- **Version**: Flutter 3.24+, Dart 3.5+
- **Benefits**: Hot reload, native performance, single codebase for 6 platforms

### 4.2 MCP Protocol (New)
- **Rationale**: Industry standard for AI agent tool integration
- **Implementation**: Custom Dart MCP server (no external dependency)
- **Transports**: stdio + HTTP/SSE + WebSocket for maximum compatibility

### 4.3 Benchmark Harness (New)
- **Rationale**: Dart's `benchmark_harness` provides statistical rigor
- **Integration**: Runs in CI, comments on PRs, exits with code 1 on regression

### 4.4 Security Tooling (New)
- **TruffleHog**: Secret scanning in git history
- **Semgrep**: Static analysis for Dart/Flutter
- **OSV Scanner**: Dependency vulnerability scanning
- **Dependency Check**: OWASP dependency vulnerability check

### 4.5 Architecture Visualization (New)
- **React Flow**: Interactive, performant graph visualization
- **Data Source**: Generated from package dependency analysis
- **Hosting**: GitHub Pages via web build

---

## 5. Security Decisions

### 5.1 Credential Storage
- **Platform Keychain/Keystore**: Use `flutter_secure_storage` for API keys, tokens
- **Environment Variables**: Never commit secrets; use `.env.example` templates
- **MCP Authentication**: API key with token expiry, per-client tokens

### 5.2 Network Security
- **Certificate Pinning**: Optional for production environments
- **TLS Enforcement**: HTTPS only for external API calls
- **Request/Response Sanitization**: Redact sensitive headers in logs/history

### 5.3 Supply Chain
- **SLSA Level 3**: Provenance generation for all artifacts
- **Dependency Pinning**: Exact versions in `pubspec.lock`
- **Vulnerability Scanning**: Automated in CI with fail thresholds

---

## 6. Performance Decisions

### 6.1 Benchmark Targets
| Operation | Target (p95) | Regression Threshold |
|-----------|--------------|---------------------|
| HTTP GET (simple) | < 100ms | 15% |
| HTTP POST (JSON 10KB) | < 200ms | 15% |
| Code Generation (Dart) | < 500ms | 15% |
| Code Generation (Python) | < 500ms | 15% |
| JSON Parse (1MB) | < 50ms | 15% |
| Collection Import (Postman 100 reqs) | < 2s | 15% |
| AI Request (local model) | < 5s | 20% |

### 6.2 Memory Management
- **Streaming**: Large responses streamed to disk, not memory
- **Lazy Loading**: Collections loaded on demand
- **Image Caching**: LRU cache for response previews

---

## 7. Scalability Considerations

### 7.1 Package Architecture
- **Loose Coupling**: Packages communicate via well-defined interfaces
- **Lazy Initialization**: Heavy packages (genai, better_networking) loaded on demand
- **Plugin Interface**: Formal extension points for custom auth, codegen, processors

### 7.2 Data Growth
- **History Pagination**: Configurable limits with auto-cleanup
- **Collection Sharding**: Large collections split by folder
- **Indexed Search**: Full-text search on request/response content

---

## 8. Deployment Architecture

### 8.1 Desktop Distribution
- **Linux**: AppImage, snap, Flatpak, .deb, .rpm, AUR
- **macOS**: DMG (notarized), Homebrew cask
- **Windows**: MSIX (Store), .exe (installer), Chocolatey, Scoop

### 8.2 Mobile Distribution
- **Android**: Play Store (AAB), GitHub Releases (APK per ABI)
- **iOS**: TestFlight → App Store (IPA)

### 8.3 Web Distribution
- **GitHub Pages**: Static PWA deployment
- **Service Worker**: Offline-first caching
- **WebAssembly**: Dart compiled to Wasm for performance

---

## 9. Testing Strategy

### 9.1 Test Pyramid
```
         /\
        /  \     E2E Tests (10)
       /----\
      /      \   Integration Tests (50)
     /--------\
    /          \ Unit Tests (500+)
   /------------\
```

### 9.2 Coverage Targets
- **Unit Tests**: > 80% line coverage per package
- **Integration Tests**: All critical user flows
- **Benchmark Tests**: All performance-critical paths
- **Security Tests**: Secret scanning, dependency checks

---

## 10. Future Improvements

### 10.1 Short-term (Next 3 months)
- [ ] GraphQL schema introspection and validation
- [ ] WebSocket/MQTT message history replay
- [ ] Team collaboration (shared collections via sync)
- [ ] OpenAPI 3.1 full support

### 10.2 Medium-term (6 months)
- [ ] Plugin marketplace
- [ ] Real-time collaboration (cursors, comments)
- [ ] API mocking server built-in
- [ ] Advanced AI: auto-documentation, contract testing

### 10.3 Long-term (12 months)
- [ ] Enterprise SSO/SAML/OIDC
- [ ] Audit logging and compliance reports
- [ ] API governance policies
- [ ] Multi-region deployment

---

## 11. Attribution

**Original Project**: API Dash by foss42 (https://github.com/foss42/apidash)
**License**: Apache-2.0
**Enhancements by**: George Nakisisa / GICT Africa Technologies
**Enhancement License**: Apache-2.0 (same as original)

This design document describes the enhanced distribution. All original API Dash code remains under its original license. New code (MCP server, African APIs, benchmarks, CI/CD, documentation) is contributed under Apache-2.0.