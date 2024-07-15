// main.dart
import 'package:flutter/material.dart';
import 'package:sima/views/welcome_screen.dart';


void main() {
  runApp(InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  const InventoryManagementApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal)
    );
  }
}
