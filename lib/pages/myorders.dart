import 'package:flutter/material.dart';
import 'package:capstone_proj/category_page.dart';

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
      backgroundColor: const Color(0xFFF1C66F),
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
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

                    // Tabs
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTab('Categories'),
                          _buildTab('Track Order'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    const Center(
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Order Card with fixed height and evenly spaced steps
                    Center(
                      child: Container(
                        width: 320,
                        height: 360, // <-- Fixed height here
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            // Vertical line from first dot to last dot
                            Positioned(
                              left: 70 + 8 + 8,
                              top: 16 + 10,
                              bottom: 16 + 10,
                              child: Container(
                                width: 4,
                                color: Colors.black,
                              ),
                            ),

                            // Evenly spaced steps
                            Column(
                              children: [
                                Expanded(child: _buildOrderStep('10:20 AM', 'Order Placed', dotColor: Colors.green)),
                                Expanded(child: _buildOrderStep('10:20 AM', 'Order is Being Prepared')),
                                Expanded(child: _buildOrderStep('10:40 AM', 'Order Packed')),
                                Expanded(child: _buildOrderStep('10:45 AM', 'Rider is on the Way')),
                                Expanded(child: _buildOrderStep('10:50 AM', 'Order Delivered')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CategoryPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B1A1A),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Back to Menu',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ This is the only part you asked to change
  Widget _buildTab(String title) {
    bool isActive = activeTab == title;

    return GestureDetector(
      onTap: () {
        if (title == 'Categories') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const CategoryPage()),
          );
        } else {
          setState(() {
            activeTab = title;
          });
        }
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  Widget _buildOrderStep(String time, String label, {Color dotColor = Colors.blue}) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time
          SizedBox(
            width: 70,
            child: Text(
              time,
              style: const TextStyle(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8.0),
          // Dot
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8.0),
          // Label
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}