import 'package:flutter/material.dart';
import 'categories/chaopan.dart';
import 'categories/bilao.dart';
import 'categories/snacks.dart';
import 'categories/platter.dart';
import 'pages/profile_page.dart';
import 'pages/address_page.dart';
import 'pages/logout_page.dart';

import 'pages/add_on_page.dart'; // Make sure this path is correct
import 'package:capstone_proj/pages/myorders.dart';

import 'pages/add_on_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String selectedCategory = 'Chaopan';

  final List<String> categories = ['Chaopan', 'Bilao', 'Snacks', 'Platter'];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentItems;

    switch (selectedCategory) {
      case 'Chaopan':
        currentItems = chaopanItems;
        break;
      case 'Bilao':
        currentItems = bilaoItems;
        break;
      case 'Snacks':
        currentItems = snacksItems;
        break;
      case 'Platter':
        currentItems = platterItems;
        break;
      default:
        currentItems = [];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFD9B56B),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset('asset/logo.png', height: 45),
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: const Text("Menu"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoryPage()),
                    (route) => false,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Address"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AddressPage()),
                  );
                },
              ),
              const Spacer(),
              const Divider(thickness: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LogoutPage(),
                              ),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                fillColor: const Color(0xFFD9D9D9),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Already on Categories
                  },
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red, // Highlight current tab
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MyOrderPage()),
                    );
                  },
                  child: const Text(
                    "Track Order",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: const Color(0xFFD9B56B),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return TextButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isSelected
                        ? const Color(0xFFF8E3AD)
                        : Colors.transparent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          // Category subtitle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              selectedCategory,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E342E),
                letterSpacing: 1.2,
                fontFamily: 'Georgia',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentItems.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = currentItems[index];
                return GestureDetector(
                  onTapDown: (_) => setState(() {}),
                  onTapUp: (_) => setState(() {}),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    height: 100, // Reduced height
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.brown.withOpacity(0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          item['code'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['description'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['price'] ?? '₱0',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E342E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () {
                            if (selectedCategory == 'Bilao') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddOnPage(),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(item['code'] ?? ''),
                                  content: Text(item['description'] ?? ''),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
