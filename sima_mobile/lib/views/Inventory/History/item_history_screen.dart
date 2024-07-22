import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/history/history_controller.dart';
import 'package:sima/views/widgets/HistoryCard.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryListScreenState();
}

class _HistoryListScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedFilter;

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("...");
      final itemP = context.read<HistoryController>();
      itemP.param = itemP.param.copyWith(
        offset: itemP.items.length,
      );
      itemP.loadMore();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryController>().getPaginationItem();
    });
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB5D9DA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/Inventory');
          },
        ),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: Consumer<HistoryController>(
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (v) {
                              final itemP = context.read<HistoryController>();
                              itemP.param = itemP.param.copyWith(
                                  limit: 10, offset: 0, itemName: v);
                              itemP.searchItems();
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search....",
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                                    Provider.of<HistoryController>(context, listen: false)
                                        .filterItemsByStatus(newValue!.toLowerCase());
                                  } else {
                                    Provider.of<HistoryController>(context, listen: false)
                                        .getPaginationItem(); // Fetch all items when 'All' is selected
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              items: <String>['All', 'In', 'Out']
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
                    const SizedBox(height: 10),
                    Column(
                      children: value.items.map((e) {
                        return HistoryCard(model: e);
                      }).toList(),
                    ),
                    if (value.isNext)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
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
