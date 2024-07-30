import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/history/history_controller.dart';
import 'package:sima/views/widgets/HistoryCard.dart';
import 'package:sima/models/history/history_pagination_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation :0.0,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pushNamed(context, '/Inventory');
          },
        ),
        title: Text(
            'History',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)
        ),
      ),
      body: Consumer<HistoryController>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final Map<String, List<HistoryPaginationModel>> itemsByDate = {};
            for (final item in value.items) {
              final date = item.createdDateFormat;
              if (!itemsByDate.containsKey(date)) {
                itemsByDate[date] = [];
              }
              itemsByDate[date]!.add(item);
            }
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(32),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.shade300.withOpacity(0.5),
                              //     spreadRadius: 4,
                              //     blurRadius: 6,
                              //     offset: const Offset(0, 1),
                              //   ),
                              // ],
                            ),
                            child: TextField(
                              onSubmitted: (v) {
                                final itemP = context.read<HistoryController>();
                                itemP.param = itemP.param.copyWith(
                                    limit: 10, offset: 0, itemName: v);
                                itemP.searchItems();
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search_rounded, color: Colors.teal,),
                                hintText: "Search....",
                                hintStyle: TextStyle(color: Colors.teal),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 2,
                            //     blurRadius: 2,
                            //     offset: const Offset(0, 1),
                            //   ),
                            // ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedFilter,
                              hint: Row(
                                children: const [
                                  Icon(Icons.filter_alt_rounded,color: Colors.teal,),
                                  SizedBox(width: 5),
                                  Text('Filter',
                                  style: TextStyle(color: Colors.teal),),
                                ],
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedFilter = newValue;
                                  if (newValue != 'All') {
                                    Provider.of<HistoryController>(context, listen: false)
                                        .filterItemsByStatus(newValue!.toLowerCase());
                                  } else {
                                    Provider.of<HistoryController>(context, listen: false)
                                        .getPaginationItem();
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: Colors.white,
                              items: <String>['All', 'In', 'Out']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.teal),),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: itemsByDate.entries.map((entry) {
                        final date = entry.key;
                        final itemsForDate = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal:16.0),
                              child: Text(
                                date,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              children: itemsForDate.map((item) {
                                return HistoryCard(model: item);
                              }).toList(),
                            ),
                          ],
                        );
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
