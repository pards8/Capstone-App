import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'network_service.dart';

class UserService {
  static const String _currentUserKey = 'current_user';

  // Register a new user to backend
  static Future<(bool success, String message)> registerUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final backendUrl = await NetworkService.getBackendUrl();
      final response = await http.post(
        Uri.parse('$backendUrl/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );
      if (response.statusCode == 201) {
        return (true, 'User registered successfully');
      } else {
        String message = 'Registration failed';
        try {
          final body = json.decode(response.body);
          if (body is Map && body['message'] is String) {
            message = body['message'];
          }
        } catch (_) {}
        return (false, message);
      }
    } catch (e) {
      print('Error registering user: $e');
      return (false, 'Unable to connect to server');
    }
  }

  // Login user to backend
  static Future<bool> loginUser(String email, String password) async {
    try {
      final backendUrl = await NetworkService.getBackendUrl();
      final response = await http.post(
        Uri.parse('$backendUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        // Optionally, you can save the token or user info from response.body
        return true;
      } else {
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  // Get current user
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_currentUserKey);
      if (userJson != null) {
        return Map<String, dynamic>.from(json.decode(userJson));
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Logout user
  static Future<void> logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_currentUserKey);
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  // Send password reset code
  static Future<(bool success, String message)> sendResetCode(
    String email,
  ) async {
    try {
      final backendUrl = await NetworkService.getBackendUrl();
      final response = await http.post(
        Uri.parse('$backendUrl/api/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        return (true, 'Reset code sent successfully');
      } else {
        String message = 'Failed to send reset code';
        try {
          final body = json.decode(response.body);
          if (body is Map && body['message'] is String) {
            message = body['message'];
          }
        } catch (_) {}
        return (false, message);
      }
    } catch (e) {
      print('Error sending reset code: $e');
      return (false, 'Unable to connect to server');
    }
  }

  // Reset password with code
  static Future<(bool success, String message)> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final backendUrl = await NetworkService.getBackendUrl();
      final response = await http.post(
        Uri.parse('$backendUrl/api/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'code': code,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return (true, 'Password reset successfully');
      } else {
        String message = 'Failed to reset password';
        try {
          final body = json.decode(response.body);
          if (body is Map && body['message'] is String) {
            message = body['message'];
          }
        } catch (_) {}
        return (false, message);
      }
    } catch (e) {
      print('Error resetting password: $e');
      return (false, 'Unable to connect to server');
    }
  }
}
