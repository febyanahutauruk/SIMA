import 'package:flutter/material.dart';
import 'package:sima/views/screens/home_screen_inventory.dart';
import 'package:sima/views/screens/welcome_screen.dart';


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
        theme: ThemeData(primarySwatch: Colors.teal),

        routes: <String,WidgetBuilder>{
      '/WelcomeScreen' : (BuildContext context) => new WelcomeScreen(),
      '/HomeScreen' : (BuildContext context) => new HomeScreen(),
      '/Inventory' : (BuildContext context) => new HomeScreenInventory(),
    }
    );
  }
}
