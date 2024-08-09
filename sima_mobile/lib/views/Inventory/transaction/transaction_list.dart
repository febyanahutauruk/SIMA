import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sima/controllers/transaction/transaction_controller.dart';
import 'package:sima/services/transaction/transaction_service.dart';
import 'package:sima/views/widgets/transaction/transaction_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima/services/transaction/add_transaction_item_form_service.dart';

import '../../../services/transaction/add_transaction_item_form_service.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Category>> _futureCategoryList;
  final TransactionService _transactionService = TransactionService();

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final transactionController = context.read<TransactionController>();
      if (transactionController.isNext && !transactionController.isLoading) {
        transactionController.loadMore();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<TransactionController>().getPaginationTransaction();
    _scrollController.addListener(scrollListener);
    _futureCategoryList = _transactionService.fetchCategoryList();
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCategoryButton(String category, Color color) {
    return Consumer<TransactionController>(
      builder: (context, transactionController, child) {
        return GestureDetector(
          onTap: () {
            if (category == 'All') {
              transactionController.filterItemsByCategory('');
            } else {
              transactionController.filterItemsByCategory(category);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.teal),
            ),
            child: Text(
              category,
              style: GoogleFonts.poppins(color: Colors.teal),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, '/Inventory');
          },
        ),
        title: Text(
          "Transactions",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/InputTransactionItemScreen');
          },
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add)),
      body: Consumer<TransactionController>(
        builder: (context, transactionController, child) {
          if (transactionController.isLoading &&
              transactionController.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.blueGrey.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0,
                      child: TextFormField(
                        onFieldSubmitted: (v) {
                          final itemP = context.read<TransactionController>();
                          itemP.param =
                              itemP.param.copyWith(itemName: v, offset: 0);
                          itemP.searchItems(v);
                        },
                        decoration: InputDecoration(
                          prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                          hintText: "Search....",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FutureBuilder<List<Category>>(
                      future: _futureCategoryList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Failed to load categories'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No categories found'));
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Hardcoded "All" button
                                _buildCategoryButton('All', Colors.white),
                                // Dynamically generated category buttons
                                ...snapshot.data!.map((category) {
                                  return _buildCategoryButton(category.name, Colors.white);
                                }).toList(),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Text("Transaction List",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.teal)),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      (transactionController.items.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        int firstIndex = index * 2;
                        int secondIndex = firstIndex + 1;

                        return Row(
                          children: [
                            Expanded(
                              child: TransactionCard(
                                  model:
                                  transactionController.items[firstIndex]),
                            ),
                            Expanded(
                              child: secondIndex <
                                  transactionController.items.length
                                  ? TransactionCard(
                                  model: transactionController
                                      .items[secondIndex])
                                  : Container(),
                            ),
                          ],
                        );
                      },
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
