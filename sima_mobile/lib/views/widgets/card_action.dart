import 'package:flutter/material.dart';
import 'package:sima/views/Inventory/MasterData/update_data_screen.dart';
import 'package:sima/views/Inventory/TransactionItem/transactionList.dart';

class CardAction extends StatelessWidget {
  const CardAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,  // Agar bottom sheet menyesuaikan tinggi konten
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();  // Tutup bottom sheet saat ikon ditap
                },
                child: Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Center(child: Text('Edit', style: TextStyle(color: Colors.grey))),
            onTap: () {
              Navigator.of(context).pop();  
              Navigator.pushNamed(context, '/assets');
            },
          ),
          Divider(),
          ListTile(
            title: Center(child: Text('Delete', style: TextStyle(color: Colors.red))),
            onTap: () {
              Navigator.of(context).pop();  
              Navigator.pushNamed(context, '/assets');
            },
          ),
        ],
      ),
    );
  }
}
