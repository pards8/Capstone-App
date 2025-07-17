import 'package:flutter/material.dart';
import '../widgets/cart_item_card.dart';
import 'ModeOfOrder.dart'; // Adjust path if needed

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'CCB', 'price': 135.0, 'quantity': 1},
    {'name': 'CLKE', 'price': 114.0, 'quantity': 1},
    {'name': 'CCBE', 'price': 135.0, 'quantity': 1},
  ];

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get subtotal {
    return cartItems.fold(
      0,
          (sum, item) => sum + item['price'] * item['quantity'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4D88F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9B56B),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart, size: 20),
            Expanded(
              child: Divider(thickness: 3, color: Colors.brown),
            ),
            Icon(Icons.local_shipping_outlined, size: 25),
            Expanded(
              child: Divider(thickness: 3, color: Colors.brown),
            ),
            Icon(Icons.check_circle_outline, size: 20),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Back + Title
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 24),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Cart',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Item List
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemCard(
                    name: item['name'],
                    price: item['price'],
                    quantity: item['quantity'],
                    onAdd: () => increaseQuantity(index),
                    onRemove: () => decreaseQuantity(index),
                    onDelete: () => removeItem(index),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Subtotal Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9B56B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal:", style: TextStyle(fontSize: 20)),
                      Text("₱ ${subtotal.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Delivery fee:", style: TextStyle(fontSize: 20)),
                      Text("₱0.00", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        "₱ ${subtotal.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModeOfOrderScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
