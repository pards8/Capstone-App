import 'package:capstone_proj/category_page.dart';
import 'package:capstone_proj/pages/cart_page.dart';
import 'package:capstone_proj/pages/checkout.dart';
import 'package:capstone_proj/pages/myorders.dart';
import 'package:capstone_proj/pages/delivery_interface.dart';
import 'package:flutter/material.dart';
import 'pages/REGISTER.dart';
import 'pages/order_confirmed_screen.dart';
import 'pages/Login.dart';
import 'package:capstone_proj/Del_Login/Del_Login.dart' as delivery_login;
import 'package:capstone_proj/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await UserService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn ? const CategoryPage() : const LoginScreen();
  }
}



