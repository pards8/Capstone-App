import 'package:flutter/material.dart';

class ModeOfOrderScreen extends StatefulWidget {
  const ModeOfOrderScreen({super.key});

  @override
  State<ModeOfOrderScreen> createState() => _ModeOfOrderScreenState();
}

class _ModeOfOrderScreenState extends State<ModeOfOrderScreen> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C261),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Back Button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 20),

            // Card containing both text and dine-in
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const Text(
                      'How would you like to receive your order',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.dinner_dining, size: 30, color: Colors.brown),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Dine-In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Enjoy your meal in our place',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.delivery_dining_outlined, size: 30, color: Colors.brown),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Enjoy your meal in our place',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.fastfood_rounded, size: 30, color: Colors.brown),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Pick-Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Enjoy your meal in our place',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 70),
            optionButton('Dine-IN', Icons.dinner_dining, 'Dine-In'),

            const SizedBox(height: 15),

            // Delivery Button
            optionButton('Delivery', Icons.delivery_dining_outlined, 'Delivery'),

            const SizedBox(height: 15),

            // Pick-Up Button
            optionButton('Pick Up', Icons.fastfood_rounded, 'Pick-Up'),
          ],
        ),
      ),
    );
  }

  Widget optionButton(String label, IconData icon, String optionValue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Switch(
          value: _selectedOption == optionValue,
          onChanged: (bool value) {
            setState(() {
              _selectedOption = value ? optionValue : '';
            });
          },
        ),
      ),
    );
  }
}