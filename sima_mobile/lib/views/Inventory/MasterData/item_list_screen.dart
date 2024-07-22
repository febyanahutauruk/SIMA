import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/items/item_controller.dart';
import 'package:sima/views/widgets/ItemCard.dart';





class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}



 class _ItemListScreenState extends State<ItemListScreen> {
  final ScrollController _scrollController = ScrollController();
  scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      print("...");
      final itemP = context.read<ItemController>();
      itemP.param = itemP.param.copyWith(
        offset: itemP.items.length,
        );
        itemP.loadMore();
    }
  }

  
  @override
  void initState() {
    context.read<ItemController>().getPaginationItem();
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Item",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: const Color(0xFFB5D9DA),
      ),
      body: Consumer<ItemController>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
            );

            } else{
              print("cek data ${value.items.length}");
              return SingleChildScrollView(
                controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (v){
                  final itemP = context.read<ItemController>();
                  itemP.param =itemP.param.copyWith(limit: 10, offset: 0, name: v);
                  itemP.searchItems();
                },              
                decoration: const InputDecoration(
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

              Column(children: value.items.map((e) {
                return ItemCard(model: e);
              }).toList(),
              ),

              if (value.isNext)
              const Center(child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      );
    }
        },
    ),
    );
  }
 }

