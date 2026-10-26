// MCP Authentication Manager
library apidash_mcp.auth;

import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../config/mcp_config.dart';

class AuthManager {
  final AuthConfig config;
  final Map<String, DateTime> _tokens = {};

  AuthManager({required this.config});

  /// Generate a new API token
  String generateToken() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final random = DateTime.now().microsecondsSinceEpoch.toString();
    final input = '$timestamp$random${config.apiKey}';
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return 'apd_${digest.toString().substring(0, 32)}';
  }

  /// Validate an API token
  bool validateToken(String token) {
    if (!config.enabled) return true;

    final expiry = _tokens[token];
    if (expiry == null) return false;
    if (DateTime.now().isAfter(expiry)) {
      _tokens.remove(token);
      return false;
    }
    return true;
  }

  /// Register a token (e.g., after successful auth)
  void registerToken(String token) {
    _tokens[token] = DateTime.now().add(config.tokenExpiry);
  }

  /// Validate API key
  bool validateApiKey(String? providedKey) {
    if (!config.enabled) return true;
    if (providedKey == null) return false;
    return providedKey == config.apiKey;
  }

  /// Check if origin is allowed
  bool isOriginAllowed(String origin) {
    return config.allowedOrigins.contains(origin);
  }

  /// Clean up expired tokens
  void cleanupExpiredTokens() {
    final now = DateTime.now();
    _tokens.removeWhere((_, expiry) => now.isAfter(expiry));
  }
}