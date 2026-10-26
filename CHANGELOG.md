# Changelog

All notable changes to API Dash Enhanced will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of API Dash Enhanced (v0.1.0)

## [0.1.0] - 2026-10-26

### Added
- **MCP Server Package** (`apidash_mcp`) — 10 tools across 6 categories for AI agent integration
  - Collection management (create, list, get, update, delete collections/folders)
  - Request management (create, send, history, save to collection)
  - Code generation (20 languages, list languages)
  - Import/Export (Postman, Insomnia, HAR, OpenAPI, cURL)
  - AI workflows (generate request, explain response, debug, generate tests, generate docs)
  - Environment management (create, list, update, delete, activate)
- **African API Collections Package** (`apidash_african_apis`) — 47 pre-built collections
  - Mobile Money (10): M-Pesa KE/TZ, MTN MoMo, Airtel Money, Orange Money, Wave, Chipper Cash, Paga, Opay, PalmPay
  - FinTech (7): Flutterwave, Paystack, Interswitch, Payfast, Ozow, Yoco, Peach Payments
  - Logistics (5): Sendy, Lori Systems, Kobo360, Truckr, GIG Logistics
  - Banking (7): Standard Bank, ABSA, FNB, Nedbank, Equity, KCB, Co-op Bank
  - Identity (3): Smile Identity, Youverify, Prembly
  - Payments (5): MFS Africa, Cellulant, DPO Group, iPay Africa, Jenga
- **Benchmark Suite** (`benchmark/`) — Regression detection with 15% threshold
  - HTTP request benchmarks (GET, POST, GraphQL, WS, MQTT, gRPC)
  - Code generation benchmarks (20 languages)
  - JSON parsing/rendering benchmarks
  - Import/Export throughput benchmarks
  - CI integration with PR comments and fail-on-regression
- **Comprehensive CI/CD Pipeline** (11 jobs)
  - Analyze & Lint (flutter analyze, dart format)
  - Unit Tests (parallel + coverage upload)
  - Integration Tests (critical user flows)
  - Multi-platform Builds (Linux, macOS, Windows, Android, iOS, Web)
  - Benchmarks (regression detection + PR comments)
  - Security Scanning (TruffleHog, Semgrep, OSV, Dependency Check)
  - SLSA Level 3 Provenance
  - Publish to pub.dev (on release)
  - Deploy Web to GitHub Pages
  - Create GitHub Release (all artifacts + checksums)
- **Architecture Visualization** — Interactive React Flow diagram
  - Package dependency graph (14 packages)
  - Data flow: Request → Network → Response → Preview → CodeGen
  - AI pipeline: DashBot → GenAI → Agentic Engine → Tools
  - Platform targets (6 platforms)
- **Interactive Documentation Tree** — React-based collapsible tree (50+ nodes)
  - Searchable, expandable, with metadata
- **Documentation Suite** (8 documents)
  - DESIGN_DOCUMENT.md
  - PORTFOLIO_CASE_STUDY.md
  - BEFORE_AFTER.md
  - Architecture Visualization Guide
  - MCP Server Guide
  - African APIs Guide
- **Security Hardening**
  - TruffleHog secret scanning (git history + working tree)
  - Semgrep SAST (Dart/Flutter + security rules)
  - OSV Scanner + OWASP Dependency Check (CVSS ≥7)
  - SLSA Level 3 provenance for all artifacts
  - Encrypted credential storage via `flutter_secure_storage`
  - MCP API key authentication with token expiry

### Changed
- Forked from API Dash v0.5.0 (foss42/apidash)
- Updated all package dependencies to latest compatible versions
- Enhanced README with badges, screenshots, quick start, architecture overview
- Added CONTRIBUTING.md, SECURITY.md, CODE_OF_CONDUCT.md

### Security
- Zero critical/high vulnerabilities in dependencies
- All secrets scanned and removed
- SLSA Level 3 provenance established

---

## Upstream Attribution

This project is a substantial enhancement fork of [API Dash](https://github.com/foss42/apidash) by [foss42](https://github.com/foss42), licensed under Apache-2.0.

Original copyright (c) 2024 foss42. Enhancements copyright (c) 2024 George Nakisisa / GICT Africa Technologies.

All original copyright notices preserved. License remains Apache-2.0.