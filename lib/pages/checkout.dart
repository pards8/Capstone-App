import 'package:flutter/material.dart';
import 'address_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isCOD = false;

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
            Icon(Icons.circle, size: 20),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and editable address
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddressPage()),
                    );
                  },
                ),

              ],
            ),
            const SizedBox(height: 10),

            const Text(
              "Mode Of Payment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),

            // COD option
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text("COD - cash on delivery",
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 20),),
                  ),
                  Radio<bool>(
                    value: true,
                    groupValue: isCOD,
                    onChanged: (value) {
                      setState(() {
                        isCOD = true;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // GCash option
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8E3AD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(2, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "G-cash Payment",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Centered QR Code
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'asset/qr_code.png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Centered Radio and Text aligned together
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: isCOD,
                        onChanged: (value) {
                          setState(() {
                            isCOD = false;
                          });
                        },
                      ),
                      const Text("Pay with GCash",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20),),
                    ],
                  ),
                ],
              ),
            ),


            const Spacer(),

            // Fees
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9B56B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal:",
                      style: TextStyle(fontSize: 20),),
                      Text("₱384.00",
                        style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery fee:",
                        style: TextStyle(fontSize: 20),),
                      Text("₱0.00",
                        style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 30),
                      ),
                      Text(
                        "₱384.00",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Order button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Submit the order
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Order Now",
                  style:
                  TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
