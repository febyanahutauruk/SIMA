import 'package:flutter/material.dart';
import 'package:sima/controllers/form/update_data_controller.dart';
import 'package:sima/models/form/update_data_model.dart';
import '../Inventory/MasterData/update_data_screen.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';

class CardAction extends StatelessWidget {
  final UpdateDataModel item;
  final UpdateDataController _updateDataController = UpdateDataController();

  CardAction({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular((16.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          ListTile(
            title: Text('Edit', textAlign: TextAlign.center),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateDataScreen(item: item),
                ),
              );
            },
          ),
          Divider(),
          ListTile(title: Text('Delete', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
            onTap: () async {
              if (item.id == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item ID is null')));
                return;
              }
              try {
                await _updateDataController.deleteItem(item.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted successfully')));
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemListScreen()));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete item: $e')));
              }
            },
          ),
          Divider(),
          ListTile(
            title: Text('Cancel', textAlign: TextAlign.center),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
