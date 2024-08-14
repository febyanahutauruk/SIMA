import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/views/Inventory/Transaction/transaction_action.dart';

class TransactionCard extends StatefulWidget {
  final TransactionPaginationModel model;
  const TransactionCard({super.key, required this.model});

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {


  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (widget.model.status == 'Available') {
      statusColor = Colors.green;
    } else if (widget.model.status == 'Unavailable') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.yellow.shade800;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(model: widget.model),
          ),
        );
      },
      child: Card(
        color: Colors.white,
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
                child:
                //  _imageFile == null
                //     ? Image.network(
                //         'https://via.placeholder.com/100',
                //         height: 100,
                //         width: 100,
                //         fit: BoxFit.cover,
                //       )
                //     : 
                    Image.network(
                        'https://apistrive.pertamina-ptk.com/WarehouseItem/${widget.model.id}/Image?isStream=true',
                        // 'https://via.placeholder.com/100',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                        'https://via.placeholder.com/100',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      );
                        },
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.model.itemName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.model.itemCategory,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Quantity: ${widget.model.qty}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Condition: ${widget.model.condition}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${widget.model.warehouseName}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
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
                    child: _buildStatusText(widget.model.status),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatusText(String status) {
  if (status == 'Available') {
    return Text(
      "Available",
      style: GoogleFonts.poppins(color: Colors.white),
    );
  } else if (status == 'Under Minimum Stock') {
    return Text(
      "Low Stock",
      style: GoogleFonts.poppins(color: Colors.white),
    );
  } else if (status == 'Unavailable') {
    return Text(
      "Unavailable",
      style: GoogleFonts.poppins(color: Colors.white),
    );
  } else {
    return Text(
      "Unknown status",
      style: GoogleFonts.poppins(color: Colors.white),
    );
  }
}
