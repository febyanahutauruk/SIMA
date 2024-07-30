import 'package:flutter/material.dart';
import 'package:sima/models/form/update_data_model.dart';
import 'package:sima/models/item/item_pagination_model.dart';
import 'package:sima/views/widgets/card_action.dart';

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
                  Text(
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: CardAction(item: UpdateDataModel(id: null, name: '', code: '', createdBy: '')),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.list,
                      size: 30,
                    ),
                  )
              )
            ],
          ),
          const Divider(),
          Text(
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Text("Tersedia",
                  style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Detail", style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.blue)),
              Icon(Icons.arrow_forward_ios, color: Colors.blue,)
            ],
          )
        ],
      ),
    );
  }
}
