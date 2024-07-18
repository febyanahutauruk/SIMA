import 'package:flutter/material.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/views/Inventory/home_screen_inventory.dart';
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
        theme: ThemeData(primarySwatch: Colors.teal),

        routes: <String,WidgetBuilder>{
      '/WelcomeScreen' : (BuildContext context) => new WelcomeScreen(),
      '/HomeScreen' : (BuildContext context) => new HomeScreen(),
      '/Inventory' : (BuildContext context) => new HomeScreenInventory(),
      '/ItemListScreen' : (BuildContext context) => new ItemListScreen(),
      // ItemListScreen.routename : (BuildContext context) =>  ItemListScreen(),
      


    }
    );
  }
}
