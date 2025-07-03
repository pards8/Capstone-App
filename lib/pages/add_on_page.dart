import 'package:flutter/material.dart';
import '../widgets/add_on_card.dart';
import 'cart_page.dart'; // Make sure the path is correct

class AddOnPage extends StatefulWidget {
  const AddOnPage({super.key});

  @override
  State<AddOnPage> createState() => _AddOnPageState();
}

class _AddOnPageState extends State<AddOnPage> {
  final Map<String, bool> _selectedAddOns = {
    'Extra-rice': false,
    'Coke': false,
    'Garlic mayo': false,
  };

  double get _basePrice => 130.0;

  double get _totalPrice {
    double total = _basePrice;
    if (_selectedAddOns['Extra-rice'] == true) total += 30.0;
    if (_selectedAddOns['Coke'] == true) total += 20.0;
    if (_selectedAddOns['Garlic mayo'] == true) total += 10.0;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0C76B),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 22),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Back to Menu",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            // Image Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      'asset/chaopan.png', // Make sure this path is correct
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chaopan Cordon Blue",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("₱130.00",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Add-ons Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: _selectedAddOns.entries.map((entry) {
                  return AddOnCard(
                    title: entry.key,
                    price: entry.key == 'Extra-rice'
                        ? 30.0
                        : entry.key == 'Coke'
                        ? 20.0
                        : 10.0,
                    value: entry.value,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddOns[entry.key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      // Bottom Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFFD9D9D9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₱${_totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C3A2E),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  CartPage()),
                );
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
