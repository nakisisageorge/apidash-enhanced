// Collection Loader
library apidash_african_apis.loader;

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'african_apis.dart';
import 'collections/mobile_money.dart';
import 'collections/fintech.dart';
import 'collections/logistics.dart';
import 'collections/banking.dart';
import 'collections/identity.dart';
import 'collections/payments.dart';
import 'environments/african_environments.dart';

/// Load all African API collections and environments
class AfricanApiLoader {
  static bool _loaded = false;
  static Map<String, dynamic>? _cachedCollections;
  static Map<String, dynamic>? _cachedEnvironments;

  /// Load all collections from embedded assets
  static Future<Map<String, dynamic>> loadCollections() async {
    if (_loaded && _cachedCollections != null) {
      return _cachedCollections!;
    }

    try {
      // Load from embedded YAML/JSON files
      final collectionsJson = await rootBundle.loadString('assets/collections/collections.json');
      final environmentsJson = await rootBundle.loadString('assets/environments/environments.json');

      _cachedCollections = jsonDecode(collectionsJson) as Map<String, dynamic>;
      _cachedEnvironments = jsonDecode(environmentsJson) as Map<String, dynamic>;
      _loaded = true;

      return _cachedCollections!;
    } catch (e) {
      // Fallback to in-memory definitions
      _cachedCollections = AfricanApis.allCollections;
      _cachedEnvironments = africanEnvironments;
      _loaded = true;
      return _cachedCollections!;
    }
  }

  /// Get all collections (synchronous, uses in-memory definitions)
  static Map<String, dynamic> get collections => AfricanApis.allCollections;

  /// Get all environments (synchronous, uses in-memory definitions)
  static Map<String, dynamic> get environments => africanEnvironments;

  /// Get a specific collection by category and name
  static Map<String, dynamic>? getCollection(String category, String name) {
    return AfricanApis.getCollection(category, name);
  }

  /// Get a specific environment by name
  static Map<String, dynamic>? getEnvironment(String name) {
    return AfricanApis.getEnvironment(name);
  }

  /// List all available categories
  static List<String> get categories => AfricanApis.categories;

  /// Get total request count
  static int get totalRequests => AfricanApis.totalRequests;

  /// Search collections by keyword
  static List<Map<String, dynamic>> searchCollections(String keyword) {
    final results = <Map<String, dynamic>>[];
    final lowerKeyword = keyword.toLowerCase();

    for (final category in collections.entries) {
      final categoryName = category.key;
      final categoryCollections = category.value as Map<String, dynamic>;

      for (final collectionEntry in categoryCollections.entries) {
        final collection = collectionEntry.value as Map<String, dynamic>;
        final collectionName = collection['name'] as String? ?? '';
        final description = collection['description'] as String? ?? '';
        final baseUrl = collection['baseUrl'] as String? ?? '';

        if (collectionName.toLowerCase().contains(lowerKeyword) ||
            description.toLowerCase().contains(lowerKeyword) ||
            baseUrl.toLowerCase().contains(lowerKeyword)) {
          results.add({
            'category': categoryName,
            'collectionKey': collectionEntry.key,
            ...collection,
          });
        }
      }
    }

    return results;
  }

  /// Get all requests for a specific API provider
  static List<Map<String, dynamic>> getRequestsForProvider(String providerKey) {
    for (final category in collections.values) {
      final catMap = category as Map<String, dynamic>;
      if (catMap.containsKey(providerKey)) {
        final collection = catMap[providerKey] as Map<String, dynamic>;
        return (collection['requests'] as List? ?? []).cast<Map<String, dynamic>>();
      }
    }
    return [];
  }

  /// Get all folders for a specific API provider
  static List<Map<String, dynamic>> getFoldersForProvider(String providerKey) {
    for (final category in collections.values) {
      final catMap = category as Map<String, dynamic>;
      if (catMap.containsKey(providerKey)) {
        final collection = catMap[providerKey] as Map<String, dynamic>;
        return (collection['folders'] as List? ?? []).cast<Map<String, dynamic>>();
      }
    }
    return [];
  }
}