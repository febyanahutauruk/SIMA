import 'package:flutter/material.dart';
import 'package:sima/models/item/item_pagination_model.dart';
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
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade200.withOpacity(1),
        //     spreadRadius: 2,
        //     blurRadius: 6,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.more_vert_rounded,
                    size: 22,
                  ))
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
