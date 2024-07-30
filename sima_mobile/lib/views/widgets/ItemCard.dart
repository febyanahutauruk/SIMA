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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Barang",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.name,
                    style: GoogleFonts.poppins(color: Colors.grey.shade400),
                  ),
                ],
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
                              id: model.id, // Pass the correct ID here
                              name: model.name,
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
            "Kode Barang    :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.code,
            style: GoogleFonts.poppins(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Kategori  :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.categoryName,
            style: GoogleFonts.poppins(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Deskripsi   :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.description,
            style: GoogleFonts.poppins(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
