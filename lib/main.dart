import 'package:capstone_proj/category_page.dart';
import 'package:capstone_proj/pages/add_on_page.dart';
import 'package:capstone_proj/pages/ModeOfOrder.dart';
import 'package:capstone_proj/pages/cart_page.dart';
import 'package:capstone_proj/pages/checkout.dart';
import 'package:capstone_proj/pages/myorders.dart';
import 'package:capstone_proj/pages/delivery_interface.dart';
import 'package:flutter/material.dart';
import 'pages/REGISTER.dart';
import 'pages/order_confirmed_screen.dart';
import 'pages/Login.dart';
import 'package:capstone_proj/Del_Login/Del_Login.dart' as delivery_login;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const delivery_login.LoginScreen(),
    );
  }
}
