import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/items/item_controller.dart';
import 'package:sima/views/widgets/ItemCard.dart';
import 'package:google_fonts/google_fonts.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedFilter;

  void scrollListener() {
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
        scrolledUnderElevation :0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, '/Inventory');
          },
        ),
        title:  Text(
          "Item",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/InputItemScreen');
          },
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add)),
      body: Consumer<ItemController>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print("cek data ${value.items.length}");
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(32),

                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.shade300.withOpacity(0.5),
                        //     spreadRadius: 2,
                        //     blurRadius: 4,
                        //     offset: const Offset(0, 1),
                        //   ),
                        // ],
                      ),
                      child: TextField(
                        onSubmitted: (v) {
                          final itemP = context.read<ItemController>();
                          itemP.param = itemP.param.copyWith(
                              limit: 10, offset: 0, name: v);
                          itemP.searchItems();
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey,),
                          hintText: "Search....",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                      ),

                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                         Text(
                        "Item List",
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.teal),
                      ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(32),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.shade300.withOpacity(0.5),
                            //     spreadRadius: 2,
                            //     blurRadius: 4,
                            //     offset: const Offset(0, 1),
                            //   ),
                            // ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedFilter,
                              hint: Row(
                                children:  [
                                  Icon(Icons.filter_alt_rounded, color: Colors.grey.shade700, size: 18,),
                                  SizedBox(width: 5),
                                  Text('Filter',
                                  style: GoogleFonts.poppins(color: Colors.grey.shade700),),
                                ],
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedFilter = newValue;
                                  if (newValue != 'All') {
                                    Provider.of<ItemController>(context,
                                        listen: false)
                                        .filterItemsBySort(
                                        newValue!.toLowerCase());
                                  } else {
                                    Provider.of<ItemController>(context,
                                        listen: false)
                                        .getPaginationItem();
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: Colors.white,
                              items: <String>['Asc', 'Desc']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: value.items.map((e) {

                        return Column(
                          children: [
                            ItemCard(model: e),
                            const SizedBox(height: 4,)
                          ],
                        );

                      }).toList(),
                    ),
                    if (value.isNext)
                      const Center(
                        child: CircularProgressIndicator(),
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
