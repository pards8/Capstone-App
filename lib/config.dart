import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkConfig {
  static const String _defaultPort = '3000';

  // Development URLs - add your common network IPs here
  static const List<String> _devUrls = [
    'http://192.168.1.8:$_defaultPort', // Your current IP
    'http://192.168.1.5:$_defaultPort', // Common home network
    'http://192.168.1.100:$_defaultPort', // Alternative home network
    'http://10.0.2.2:$_defaultPort', // Android emulator
    'http://localhost:$_defaultPort', // Local development
  ];

  // Production URL - Replace with your actual production backend URL
  static const String _prodUrl =
      'https://your-capstone-backend.herokuapp.com'; // or your deployed backend URL

  static String get backendBaseUrl {
    if (kReleaseMode) {
      // Production mode - use production URL
      return _prodUrl;
    }

    // Development mode - try to find the best available URL
    return _getBestDevUrl();
  }

  static String _getBestDevUrl() {
    // For now, return the first dev URL
    // In a more sophisticated implementation, you could ping each URL
    // to find which one is reachable
    return _devUrls.first;
  }

  // Method to get all possible URLs for testing
  static List<String> get allPossibleUrls {
    if (kReleaseMode) {
      return [_prodUrl];
    }
    return _devUrls;
  }

  // Debug method - only available in debug mode
  static List<String> get debugUrls {
    if (kReleaseMode) {
      return [];
    }
    return _devUrls;
  }

  // Method to test connectivity to backend
  static Future<String?> testBackendConnectivity() async {
    for (String url in _devUrls) {
      try {
        final response = await HttpClient()
            .getUrl(Uri.parse('$url/api/health'))
            .timeout(const Duration(seconds: 3));
        final result = await response.close();
        if (result.statusCode == 200) {
          return url;
        }
      } catch (e) {
        // Continue to next URL
        continue;
      }
    }
    return null;
  }
}

// Legacy support - keep the old variable name for backward compatibility
String get backendBaseUrl => NetworkConfig.backendBaseUrl;
