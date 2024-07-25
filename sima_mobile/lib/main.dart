import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/items/item_controller.dart';
import 'package:sima/views/Inventory/History/item_history_screen.dart';
import 'package:sima/views/Inventory/Maps/maps_screen.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/views/Inventory/TransactionItem/transactionList.dart';
import 'package:sima/views/Inventory/home_screen_inventory.dart';
import 'package:sima/views/welcome_screen.dart';
import 'package:sima/controllers/history/history_controller.dart';
import 'package:sima/controllers/dashboard/dashboard_controller.dart';


void main() {
  runApp(const InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  const InventoryManagementApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => ItemController()),
        ChangeNotifierProvider(create:(_) => HistoryController()),
        ChangeNotifierProvider(create:(_) => DashboardItemController())
      ],

      child: MaterialApp(
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),

        routes: <String,WidgetBuilder>{
      '/WelcomeScreen' : (BuildContext context) => const WelcomeScreen(),
      '/HomeScreen' : (BuildContext context) => const HomeScreen(),
      '/Inventory' : (BuildContext context) => const HomeScreenInventory(),
      '/ItemListScreen' : (BuildContext context) => const ItemListScreen(),
      '/History' : (BuildContext context) => const HistoryScreen(),
      '/TransactionList' : (BuildContext context) => const TransactionList(),
      '/Maps' : (BuildContext context) =>  MapScreen(),
      // ItemListScreen.routename : (BuildContext context) =>  ItemListScreen(),


    }
    )
    );
  }
}
