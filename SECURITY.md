# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | ✅ Yes             |
| < 0.1   | ❌ No              |

## Reporting a Vulnerability

We take security vulnerabilities seriously. If you discover a security issue, please report it responsibly.

### Private Disclosure

**Please do NOT report security vulnerabilities via public GitHub issues.**

Instead, please report via:
- **Email**: security@gictafrica.com (PGP key available on request)
- **GitHub Security Advisories**: Use the "Report a vulnerability" tab on GitHub

### What to Include
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)
- Your contact information

### Response Timeline
- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 7 days
- **Fix Timeline**: Depends on severity
  - Critical: 7 days
  - High: 14 days
  - Medium: 30 days
  - Low: 60 days

We will keep you informed of progress throughout the process.

## Security Measures

### Implemented Protections
- **Secret Scanning**: TruffleHog on every commit/PR
- **Static Analysis**: Semgrep with Dart/Flutter security rules
- **Dependency Scanning**: OSV + OWASP Dependency Check (CVSS ≥7 fails build)
- **Supply Chain**: SLSA Level 3 provenance for all artifacts
- **Credential Storage**: Platform keychain/keystore via `flutter_secure_storage`
- **MCP Authentication**: API key + token expiry + CORS

### Secure Development Practices
- No hardcoded secrets (enforced by CI)
- Dependency pinning in `pubspec.lock`
- Regular dependency updates via Dependabot
- Code review required for all changes
- Security-focused code review checklist

## Vulnerability Disclosure Policy

We follow coordinated vulnerability disclosure:

1. **Private Report** → We acknowledge within 48 hours
2. **Validation** → We reproduce and assess impact
3. **Fix Development** → We develop and test fix
4. **Coordinated Release** → We publish fix and advisory simultaneously
3. **Credit** → We credit reporter (unless anonymity requested)

## Scope

### In Scope
- API Dash Enhanced application code
- MCP server implementation
- African API collections
- Benchmark suite
- CI/CD pipelines
- Documentation

### Out of Scope
- Original API Dash (foss42/apidash) — report upstream
- Third-party dependencies — report to respective maintainers
- Flutter/Dart SDK — report to Google
- Platform-specific issues (OS, hardware)

## Bug Bounty

We do not currently operate a formal bug bounty program. However, we recognize significant security contributions in our [Hall of Fame](https://github.com/nakisisageorge/apidash-enhanced/security/advisories) and release notes.

## Contact

- **Security Email**: security@gictafrica.com
- **General Contact**: nakisisageorge@gmail.com
- **PGP Key**: Available on request

---

*This security policy is adapted from industry best practices and will be updated as the project evolves.*