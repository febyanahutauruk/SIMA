// screens/order_screen.dart
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add order submission logic here
              },
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
