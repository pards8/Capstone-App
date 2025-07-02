import 'package:flutter/material.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  String activeTab = 'Track Order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1C66F), // Mustard gold background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Centered logo and right hamburger
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'asset/logo.jpg',
                      height: 50,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.menu, size: 30, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Tabs: Categories and Track Order
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Categories tab
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeTab = 'Categories';
                        });
                      },
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 16,
                          color: activeTab == 'Categories'
                              ? Colors.red
                              : Colors.black,
                          fontWeight: activeTab == 'Categories'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        child: const Text('Categories'),
                      ),
                    ),
                  ),

                  // Track Order tab
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeTab = 'Track Order';
                        });
                      },
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 16,
                          color: activeTab == 'Track Order'
                              ? Colors.red
                              : Colors.black,
                          fontWeight: activeTab == 'Track Order'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        child: const Text('Track Order'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Page Title
            const Center(
              child: Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const Spacer(),

            // Back to Menu Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation logic here if needed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B1A1A), // Deep red
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Back to Menu',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
