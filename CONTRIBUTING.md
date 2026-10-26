# Contributing to API Dash Enhanced

Thank you for your interest in contributing! This document outlines the process for contributing to API Dash Enhanced.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

## How to Contribute

### Reporting Bugs
1. Check [existing issues](https://github.com/nakisisageorge/apidash-enhanced/issues) first
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots (if applicable)
   - Environment (OS, Flutter version, device)

### Requesting Features
1. Check [existing feature requests](https://github.com/nakisisageorge/apidash-enhanced/discussions/categories/ideas)
2. Create a discussion or issue with:
   - Clear use case
   - Proposed solution
   - Alternatives considered
   - Impact assessment

### Submitting Pull Requests

#### Before You Start
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Run tests and checks (see below)
5. Submit PR to `main` branch

#### PR Requirements
- [ ] Clear title and description
- [ ] Linked issue (if applicable)
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or documented in PR)
- [ ] All CI checks pass

#### Code Standards
- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format` before committing
- Run `flutter analyze` — zero errors/warnings
- Add tests for new functionality
- Update relevant documentation

### African API Contributions

We especially welcome new African API collections!

#### Adding a New API Collection
1. Create collection file in `packages/apidash_african_apis/lib/src/collections/`
2. Follow existing patterns (see `mobile_money.dart`, `fintech.dart`)
3. Include:
   - Base URL (sandbox + production)
   - Authentication method
   - Key endpoints with examples
   - Environment configuration
4. Add environment to `african_environments.dart`
5. Update `african_apis.dart` to export new collection
6. Add tests in `packages/apidash_african_apis/test/`
7. Update [African APIs Guide](docs/guides/AFRICAN_APIS_GUIDE.md)

#### Collection Template
```dart
const Map<String, dynamic> newApiCollection = {
  'name': 'Provider Name',
  'description': 'Brief description',
  'baseUrl': 'https://api.provider.com',
  'authType': 'oauth2|api_key|subscription|hmac|basic',
  'folders': [
    {'name': 'Folder Name', 'requests': ['req_id_1', 'req_id_2']},
  ],
  'requests': [
    {
      'id': 'unique_req_id',
      'name': 'Request Name',
      'method': 'POST',
      'path': '/endpoint',
      'headers': {'Content-Type': 'application/json'},
      'body': {'key': 'value'},
      'description': 'What this request does',
    },
  ],
};
```

### Development Setup

```bash
# Clone and setup
git clone https://github.com/nakisisageorge/apidash-enhanced.git
cd apidash-enhanced
melos bootstrap

# Verify setup
melos exec -c 1 -- flutter analyze
melos exec -c 1 -- flutter test
```

### Testing
```bash
# Unit tests
melos exec -c 1 -- flutter test --coverage

# Integration tests
flutter test integration_test/

# Benchmarks
cd benchmark && dart run benchmark_runner.dart
```

### Documentation
- Update relevant `.md` files
- Update code comments for public APIs
- Add examples for new features
- Architecture changes → update [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md)

## Release Process

Releases are automated via GitHub Actions on tag push:
```bash
git tag v0.1.0
git push origin v0.1.0
```

This triggers:
- Multi-platform builds
- Security scans
- SLSA provenance
- pub.dev publishing
- GitHub Release creation
- GitHub Pages deployment

## Getting Help

- **Discord**: [API Dash Community](https://discord.gg/apidash)
- **Discussions**: [GitHub Discussions](https://github.com/nakisisageorge/apidash-enhanced/discussions)
- **Email**: nakisisageorge@gmail.com

## Recognition

Contributors are recognized in:
- [CONTRIBUTORS.md](CONTRIBUTORS.md)
- Release notes
- GitHub contributor graph

Thank you for making API Dash Enhanced better! 🚀