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
  String? _selectedFilter;
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        hint: Row(
                          children: const [
                            Icon(Icons.filter_list),
                            SizedBox(width: 5),
                            Text('Filter'),
                          ],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFilter = newValue;
                            if (newValue != 'All') {
                              // Access the HistoryController instance using Provider
                              Provider.of<ItemController>(context, listen: false)
                                  .filterItemsBySort(newValue!.toLowerCase());
                            } else {
                              Provider.of<ItemController>(context, listen: false)
                                  .getPaginationItem(); // Fetch all items when 'All' is selected
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: Colors.white,
                        items: <String>['Asc','Desc']
                            .map<DropdownMenuItem<String>>((String value) {
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

