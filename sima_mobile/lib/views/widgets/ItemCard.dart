import 'package:flutter/material.dart';
import 'package:sima/models/item/item_pagination_model.dart';

class ItemCard extends StatelessWidget {
  final ItemPaginationModel model;
  const ItemCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
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
                  const Text(
                    "Nama Barang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.name),
                ],
              ),
              const Spacer(),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.list,
                    size: 32,
                  ))
            ],
          ),
          const Divider(),
          const Text(
            "Kode Barang    :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(model.code),
          const Text(
            "Kategori  :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(model.categoryName),
          const Text(
            "Deskripsi   :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(model.description),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Status",style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Text("Tersedia",
                    style: TextStyle(color: Colors.white),)),
            ],
          ),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Detail",style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.blue)),
              Icon(Icons.arrow_forward_ios, color: Colors.blue,)
            ],
          )
        ],
      ),
    );
  }
}
