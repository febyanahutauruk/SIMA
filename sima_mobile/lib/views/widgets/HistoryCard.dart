import 'package:sima/models/history/history_pagination_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      icon = Icons.arrow_downward_rounded;
      iconColor = Colors.teal;
      statusColor = Colors.teal;
      quantityText = 'Qty: +${model.qtyInOut}';
      quantityColor = Colors.teal;
    } else if (model.status.toLowerCase() == 'out') {
      icon = Icons.arrow_upward_rounded;
      iconColor = Colors.red;
      statusColor = Colors.red;
      quantityText = 'Qty: -${model.qtyInOut}';
      quantityColor = Colors.red;
    } else {
      icon = Icons.help_outline_rounded; 
      iconColor = Colors.grey;
      statusColor = Colors.grey;
      quantityText = '${model.qtyInOut}'; 
      quantityColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade300.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 4,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(5),
        color: Colors.blueGrey.shade50,
        child: ListTile(
          leading: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0), 
              child: Icon(icon, color: iconColor),
            ),
          ),
          title: Text(model.itemName, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.warehouseName, style: GoogleFonts.poppins(fontSize: 12)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(quantityText,
                  style: GoogleFonts.poppins(
                      color: quantityColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
