import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/items/item_controller.dart';
import 'package:sima/controllers/transaction/transaction_controller.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/views/Inventory/History/item_history_screen.dart';
import 'package:sima/views/Inventory/Maps/maps_screen.dart';
import 'package:sima/views/Inventory/MasterData/add_item_screen.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/views/Inventory/Transaction/add_transaction_item_screen.dart';
import 'package:sima/views/Inventory/Transaction/transaction_list.dart';
import 'package:sima/views/Inventory/Transaction/transaction_action.dart';
import 'package:sima/views/Inventory/home_screen_inventory.dart';
import 'package:sima/views/welcome_screen.dart';
import 'package:sima/controllers/history/history_controller.dart';
import 'package:sima/controllers/dashboard/dashboard_controller.dart';

void main() {
  runApp(const InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {

  const InventoryManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => TransactionController()),
        ChangeNotifierProvider(create:(_) => ItemController()),
        ChangeNotifierProvider(create:(_) => HistoryController()),
        ChangeNotifierProvider(create:(_) => DashboardItemController())

      ],
      child: MaterialApp(
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),

        routes: <String,WidgetBuilder>{

      '/WelcomeScreen' : (BuildContext context) => new WelcomeScreen(),
      '/HomeScreen' : (BuildContext context) => new HomeScreen(),
      '/Inventory' : (BuildContext context) => new HomeScreenInventory(),
      '/ItemListScreen' : (BuildContext context) => new ItemListScreen(),
      '/History' : (BuildContext context) => new HistoryScreen(),
      '/TransactionList' : (BuildContext context) => new TransactionListScreen(),
      '/Maps' : (BuildContext context) => new MapScreen(),
      '/InputItemScreen' : (BuildContext context) => new InputItemScreen(),
      '/ProductDetailScreen': (context) => new ProductDetailScreen(model: ModalRoute.of(context)!.settings.arguments as TransactionPaginationModel),
      '/InputTransactionItemScreen' : (BuildContext context) => new InputTransactionItemScreen(),

      // ItemListScreen.routename : (BuildContext context) =>  ItemListScreen(),


    }
    )
    );
  }
}
