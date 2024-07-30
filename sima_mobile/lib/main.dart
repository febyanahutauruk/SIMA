import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/items/item_controller.dart';
import 'package:sima/controllers/transaction/transaction_controller.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/views/Inventory/History/item_history_screen.dart';
import 'package:sima/views/Inventory/Maps/maps_screen.dart';
import 'package:sima/views/Inventory/MasterData/add_item_screen.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/views/Inventory/MasterData/update_data_screen.dart';
import 'package:sima/views/Inventory/Transaction/transaction_list.dart';
import 'package:sima/views/Inventory/Transaction/transaction_action.dart';
import 'package:sima/views/Inventory/home_screen_inventory.dart';
import 'package:sima/views/welcome_screen.dart';

void main() {
  runApp(InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  const InventoryManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemController()),
        ChangeNotifierProvider(create: (_) => TransactionController()),
      ],
      child: MaterialApp(
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        routes: <String, WidgetBuilder>{
          '/WelcomeScreen': (BuildContext context) => WelcomeScreen(),
          '/HomeScreen': (BuildContext context) => HomeScreen(),
          '/Inventory': (BuildContext context) => HomeScreenInventory(),
          '/ItemListScreen': (BuildContext context) => ItemListScreen(),
          '/History': (BuildContext context) => HistoryScreen(),
          '/TransactionList': (BuildContext context) => TransactionListScreen(),
          '/ProductDetailScreen': (context) => ProductDetailScreen(model: ModalRoute.of(context)!.settings.arguments as TransactionPaginationModel),
          '/Maps': (BuildContext context) => MapScreen(),
          '/InputItemScreen': (BuildContext context) => InputItemScreen(),
          // '/UpdateDataScreen': (BuildContext context) => UpdateDataScreen(),
        },
      ),
    );
  }
}
