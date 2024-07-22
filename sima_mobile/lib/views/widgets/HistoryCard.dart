// history_card.dart
import 'package:sima/models/history/history_pagination_model.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final HistoryPaginationModel model;
  const HistoryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;
    Color statusColor;
    String quantityText;
    Color quantityColor;

    if (model.status.toLowerCase() == 'in') {
      icon = Icons.arrow_downward;
      iconColor = Colors.teal;
      statusColor = Colors.teal;
      quantityText = '+${model.qtyInOut}';
      quantityColor = Colors.teal;
    } else if (model.status.toLowerCase() == 'out') {
      icon = Icons.arrow_upward;
      iconColor = Colors.red;
      statusColor = Colors.red;
      quantityText = '-${model.qtyInOut}';
      quantityColor = Colors.red;
    } else {
      icon = Icons.help_outline; // Default icon for unknown status
      iconColor = Colors.grey;
      statusColor = Colors.grey;
      quantityText = '${model.qtyInOut}'; // No prefix for unknown status
      quantityColor = Colors.grey;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(model.itemName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.warehouseName),
            Text(
              quantityText,
              style: TextStyle(
                  color: quantityColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.createdDateFormat),
            Text(model.status,
                style: TextStyle(
                    color: statusColor,
                    fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
