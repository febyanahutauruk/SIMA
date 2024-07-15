// screens/item_history_screen.dart
import 'package:flutter/material.dart';

class ItemHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item History'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with dynamic item history count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item History $index'), // Replace with item history details
          );
        },
      ),
    );
  }
}
