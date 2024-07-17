import 'package:flutter/material.dart';

class KelolaItemScreen extends StatefulWidget {
  const KelolaItemScreen({super.key});

  @override
  State<KelolaItemScreen> createState() => KelolaItemScreenState();
}

class KelolaItemScreenState extends State<KelolaItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management Inventory'),
      ),
      body: const Center(
        child: Text('Management Inventory'),
      ),
    );
  }
}
