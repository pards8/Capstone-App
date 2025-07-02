// lib/pages/logout_page.dart
import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logged Out')),
      body: const Center(
        child: Text('You have been logged out.'),
      ),
    );
  }
}
