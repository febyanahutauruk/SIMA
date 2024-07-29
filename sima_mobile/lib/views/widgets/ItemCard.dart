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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(1),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Text(
            "Kode Barang    :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.code,
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Kategori  :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.categoryName,
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Deskripsi   :",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Text(
            model.description,
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context, '/DetailItemScreen'
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "See Detail",
                  style: GoogleFonts.poppins(color: Colors.blue),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.blue,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
