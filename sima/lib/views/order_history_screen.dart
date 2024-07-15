import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with dynamic order count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order $index'), // Replace with order details
          );
        },
      ),
    );
  }
}
