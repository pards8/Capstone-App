import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2C261),
    body: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 40),
    // Logo (top-left)
    SizedBox(
    height: 40,
    child: Image.asset('asset/logo.jpg'), // Make sure the image is in 'assets/logo.png'
    ),
    const SizedBox(height: 60),
    // Registration Title
    Center(
    child: Column(
    children: const [
    Text(
    'Registration',
    style: TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.brown,
    ),
    ),
    Text(
    'Form',
    style: TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.brown,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 40),
    // Name Label and Field
    const Text(
    'Name',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    const SizedBox(height: 8),
    buildTextField(),
    const SizedBox(height: 20),
    // Email Label and Field
    const Text(
    'Email Addressss',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    const SizedBox(height: 8),
    buildTextField(),
    ],
    ),
    ),
    );
  }

  Widget buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
