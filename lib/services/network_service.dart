import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class NetworkService {
  static String? _cachedBackendUrl;
  static DateTime? _lastCacheTime;
  static const Duration _cacheDuration = Duration(minutes: 5);

  /// Get the best available backend URL
  static Future<String> getBackendUrl() async {
    // Check if we have a cached URL that's still valid
    if (_cachedBackendUrl != null && _lastCacheTime != null) {
      if (DateTime.now().difference(_lastCacheTime!) < _cacheDuration) {
        return _cachedBackendUrl!;
      }
    }

    // Test connectivity to find the best URL
    final workingUrl = await testBackendConnectivity();
    if (workingUrl != null) {
      _cachedBackendUrl = workingUrl;
      _lastCacheTime = DateTime.now();
      return workingUrl;
    }

    // Fallback to the default URL
    return NetworkConfig.backendBaseUrl;
  }

  /// Test connectivity to all possible backend URLs
  static Future<String?> testBackendConnectivity() async {
    final urls = NetworkConfig.allPossibleUrls;

    for (String url in urls) {
      try {
        final response = await http
            .get(
              Uri.parse('$url/api/health'),
              headers: {'Content-Type': 'application/json'},
            )
            .timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          print('✅ Backend found at: $url');
          return url;
        }
      } catch (e) {
        print('❌ Failed to connect to: $url - ${e.toString()}');
        continue;
      }
    }

    print('⚠️ No backend URLs are reachable');
    return null;
  }

  /// Clear the cached backend URL
  static void clearCache() {
    _cachedBackendUrl = null;
    _lastCacheTime = null;
  }

  /// Get current network status (debug only)
  static Future<Map<String, dynamic>> getNetworkStatus() async {
    if (kReleaseMode) {
      return {}; // Don't expose network info in release mode
    }

    final urls = NetworkConfig.debugUrls;
    final status = <String, bool>{};

    for (String url in urls) {
      try {
        final response = await http
            .get(
              Uri.parse('$url/api/health'),
              headers: {'Content-Type': 'application/json'},
            )
            .timeout(const Duration(seconds: 2));

        status[url] = response.statusCode == 200;
      } catch (e) {
        status[url] = false;
      }
    }

    return status;
  }

  /// Check if the app is running on an emulator
  static bool get isEmulator {
    return Platform.isAndroid &&
        (Platform.environment.containsKey('ANDROID_EMULATOR') ||
            Platform.environment.containsKey('ANDROID_SDK_ROOT'));
  }

  /// Get the recommended backend URL based on platform
  static String get recommendedBackendUrl {
    if (isEmulator) {
      return 'http://10.0.2.2:3000';
    }
    return NetworkConfig.backendBaseUrl;
  }
}
