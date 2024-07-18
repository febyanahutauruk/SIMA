import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Barang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("KD1234"),
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
            "Kategori    :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Furnitur"),
          const Text(
            "Deskripsi  :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Furnitur Kantor"),
          const Text(
            "Quantity   :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("60"),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status",style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text("Tersedia",
                    style: TextStyle(color: Colors.white),)),
            ],
          ),
          Divider(),
          Row(
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
