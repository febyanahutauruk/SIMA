import 'dart:ui';

// import 'package:belajar_provider/CONFIG/mycolors.dart';
// import 'package:belajar_provider/widgets/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sima/models/item/item_pagination_model.dart';
import 'package:sima/views/widgets/ItemCard.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Item",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Color(0xFFB5D9DA),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search....",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Daftar Item",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Show",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const SizedBox(
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_up),
                          contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          hintText: "10",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Entries",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.sensor_window_rounded),
                        Text("Filter",
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              ItemCard(
                model: ItemPaginationModel(
                  code: "123099",
                  name: "meja",
                  categoryName: "furniture",
                  description: "meja",
                  id: 0 ,
                )
              ),
              ItemCard(
                model: ItemPaginationModel(
                  code: "647599",
                  name: "meja",
                  categoryName: "furniture",
                  description: "meja",
                  id: 0 ,
                )
              ),
              ItemCard(
                model: ItemPaginationModel(
                  code: "123456",
                  name: "meja",
                  categoryName: "furniture",
                  description: "meja",
                  id: 0 ,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
