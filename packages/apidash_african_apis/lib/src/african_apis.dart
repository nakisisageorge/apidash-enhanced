// African API Collections Core
library apidash_african_apis.african_apis;

import 'collections/mobile_money.dart';
import 'collections/fintech.dart';
import 'collections/logistics.dart';
import 'collections/banking.dart';
import 'collections/identity.dart';
import 'collections/payments.dart';
import 'environments/african_environments.dart';

/// Main entry point for African API collections
class AfricanApis {
  static const String version = '0.1.0';
  static const String description = 'Pre-built African API collections for mobile money, fintech, logistics, and banking';

  /// Get all available collections
  static Map<String, dynamic> get allCollections => {
    'mobile_money': mobileMoneyCollections,
    'fintech': fintechCollections,
    'logistics': logisticsCollections,
    'banking': bankingCollections,
    'identity': identityCollections,
    'payments': paymentsCollections,
  };

  /// Get all available environments
  static Map<String, dynamic> get allEnvironments => africanEnvironments;

  /// Get collection by category and name
  static Map<String, dynamic>? getCollection(String category, String name) {
    final categoryCollections = allCollections[category] as Map<String, dynamic>?;
    return categoryCollections?[name] as Map<String, dynamic>?;
  }

  /// Get environment by name
  static Map<String, dynamic>? getEnvironment(String name) {
    return allEnvironments[name] as Map<String, dynamic>?;
  }

  /// List all collection categories
  static List<String> get categories => allCollections.keys.toList();

  /// Get total count of requests across all collections
  static int get totalRequests {
    int count = 0;
    for (final category in allCollections.values) {
      final catMap = category as Map<String, dynamic>;
      for (final collection in catMap.values) {
        final collMap = collection as Map<String, dynamic>;
        count += (collMap['requests'] as List? ?? []).length;
      }
    }
    return count;
  }
}