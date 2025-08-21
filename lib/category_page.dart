import 'package:flutter/material.dart';
import 'categories/chaopan.dart';
import 'categories/bilao.dart';
import 'categories/snacks.dart';
import 'categories/platter.dart';
import 'pages/profile_page.dart';
import 'pages/address_page.dart';
import 'pages/logout_page.dart';
import 'pages/add_on_page.dart'; // Make sure this path is correct

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
            child: Image.asset(
              'asset/logo.png',
              height: 45,
            ),
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
                title: const Text("Logout", style: TextStyle(color: Colors.red)),
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
                              MaterialPageRoute(builder: (_) => const LogoutPage()),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Track Order", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        // Image on the left - smaller size
                        Expanded(
                          flex: 2, // Reduced from 3 to 2
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: item['image'] != null
                                ? TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration: const Duration(milliseconds: 600),
                                    builder: (context, value, child) => Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                    child: Image.asset(
                                      item['image']!,
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.fastfood,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.fastfood,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                        // Menu info on the right - more space
                        Expanded(
                          flex: 3, // Increased from 2 to 3
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Title and badge
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['code'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xFF4E342E),
                                          fontFamily: 'Georgia',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (index == 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE9C46A),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: const Text(
                                          '★',
                                          style: TextStyle(
                                            color: Color(0xFF4E342E),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                // Description
                                Text(
                                  item['description'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontFamily: 'Georgia',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Price and button row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['price'] ?? '₱0',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6D6D6D),
                                        fontSize: 14,
                                        fontFamily: 'Georgia',
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF4E342E),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        minimumSize: const Size(0, 0),
                                        elevation: 1,
                                      ),
                                      onPressed: () {
                                        if (selectedCategory == 'Bilao') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => const AddOnPage()),
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
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "More",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          fontFamily: 'Georgia',
                                        ),
                                      ),
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
