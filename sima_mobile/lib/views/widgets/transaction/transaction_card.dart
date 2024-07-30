import 'package:flutter/material.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/views/Inventory/Transaction/transaction_action.dart';

class TransactionCard extends StatelessWidget {
  final TransactionPaginationModel model;
  const TransactionCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (model.qty > model.minQty) {
      statusColor = Colors.green;
    } else if (model.qty < model.minQty) {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey; 
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(model: model),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  model.fileUrl ?? 'https://via.placeholder.com/100',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                model.itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                model.itemCategory,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Quantity: ${model.qty}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Warehouse: ${model.warehouseName}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      model.qty > model.minQty ? 'Tersedia' : 'Tidak Tersedia',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
