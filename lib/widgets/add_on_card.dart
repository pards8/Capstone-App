import 'package:flutter/material.dart';

class AddOnCard extends StatelessWidget {
  final String title;
  final double price;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AddOnCard({
    super.key,
    required this.title,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Checkbox(value: value, onChanged: onChanged),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 14)),
            ),
            Text('₱${price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
