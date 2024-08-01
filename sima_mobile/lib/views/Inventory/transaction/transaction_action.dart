import 'package:flutter/material.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/services/transaction/transaction_service.dart';
import 'package:sima/models/transaction/transaction_param_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final TransactionPaginationModel model;

  const ProductDetailScreen({super.key, required this.model});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? _selectedAction;
  int _qtyInOut = 1;
  final TextEditingController _qtyInOutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _qtyInOutController.text = _qtyInOut.toString();
  }

  @override
  void dispose() {
    _qtyInOutController.dispose();
    super.dispose();
  }

  void _updateQtyInOut(String value) {
    int? qtyInOut = int.tryParse(value);
    if (qtyInOut != null && qtyInOut > 0) {
      setState(() {
        _qtyInOut = qtyInOut;
      });
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Action"),
        content: const Text("Are you sure you want to submit this action?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _submitAction();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAction() async {
    if (_selectedAction == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an action')),
      );
      return;
    }

    try {
      final TransactionService transactionService = TransactionService();
      final actionType = _selectedAction == 1 ? "IN" : "OUT";

      final itemInOut = TransactionParamModel(
        limit: 4,
        offset: 0,
        id: widget.model.id,
        itemName: widget.model.itemName,
        itemCategory: widget.model.itemCategory,
        status: actionType,
        qty: widget.model.qty, 
        qtyInOut: _qtyInOut,
        date: widget.model.date, 
        warehouseItemId: widget.model.warehouseItemId,
        aktor: widget.model.aktor,  
        d: widget.model.d,
      );

      await transactionService.addItemInOut(itemInOut);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Action failed: $e')),
      );
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Adjust Quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (_qtyInOut > 1) {
                                  _qtyInOut--;
                                  _qtyInOutController.text = _qtyInOut.toString();
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _qtyInOutController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _updateQtyInOut(value);
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Quantity In/Out",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _qtyInOut++;
                                _qtyInOutController.text = _qtyInOut.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: const Text("Barang Masuk",
                                style: TextStyle(fontSize: 16)),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: const Text("Barang Keluar",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                        onSelected: (value) {
                          setState(() {
                            _selectedAction = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedAction != null) {
                        Navigator.of(context).pop();
                        _showConfirmationDialog(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an action')),
                        );
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                'https://apistrive.pertamina-ptk.com/WarehouseItem/${widget.model.id}/Image?isStream=true',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://via.placeholder.com/100',
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Product Name: ${widget.model.itemName}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Product Category: ${widget.model.itemCategory}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Quantity: ${widget.model.qty}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Warehouse : ${widget.model.warehouseName}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 220),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showBottomSheet,
                  child: const Text(
                    "Add Action",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
