import 'package:flutter/material.dart';
import 'package:sima/models/form/update_data_model.dart';
import 'package:sima/models/item/item_pagination_model.dart';
import 'package:sima/views/widgets/card_action.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final ItemPaginationModel model;
  const ItemCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding( 
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text(
                    "Product Name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.name,
                    style: GoogleFonts.poppins(color: Colors.grey.shade400),overflow: TextOverflow.ellipsis,
                  ),
                ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: CardAction(
                            item: UpdateDataModel(
                              id: model.id,
                              name:model.name,
                              code: model.code,
                              description: model.description,
                              createdBy: model.createdBy,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.menu_rounded,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
              )
            ],

            ),
            const Divider(),
            Text(
              "Product Code   :",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            Text(
              model.code,
              style: GoogleFonts.poppins(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Category   :",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            Text(
              model.categoryName,
              style: GoogleFonts.poppins(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Description   :",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            Text(
              model.description,
              style: GoogleFonts.poppins(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}