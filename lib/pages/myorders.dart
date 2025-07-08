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
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Order Card with dots and vertical line
                    Center(
                      child: Container(
                        width: 320,
                        height: 360,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            // Vertical line
                            Positioned(
                              left: 70 + 8 + 8,
                              top: 24,
                              bottom: 24,
                              child: Container(
                                width: 4,
                                color: Colors.black,
                              ),
                            ),

                            // Time + Dot Rows
                            Column(
                              children: const [
                                Expanded(child: _TimeDotRow(time: '10:20 AM', dotColor: Colors.green)),
                                Expanded(child: _TimeDotRow(time: '10:25 AM')),
                                Expanded(child: _TimeDotRow(time: '10:40 AM')),
                                Expanded(child: _TimeDotRow(time: '10:45 AM')),
                                Expanded(child: _TimeDotRow(time: '10:50 AM')),
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
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    bool isActive = activeTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = title;
        });
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
}


class _TimeDotRow extends StatelessWidget {
  final String time;
  final Color dotColor;

  const _TimeDotRow({
    required this.time,
    this.dotColor = Colors.blue, // default to blue
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 8),
        // Dot
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
