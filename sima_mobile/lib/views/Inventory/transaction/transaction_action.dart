import 'package:flutter/material.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/services/transaction/in_out_service.dart';
import 'package:sima/models/transaction/in_out_model.dart';
import 'package:sima/views/Inventory/Transaction/transaction_list.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 10),
            Text("Confirm Action"),
          ],
        ),
        content: Text(
          "Are you sure you want to submit this action?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _submitAction();
            },
            child: const Text("Confirm",
            style: TextStyle(color: Colors.white),),
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
      final InOutService inOutService = InOutService();
      final actionType = _selectedAction == 1 ? "IN" : "OUT";
      var Id = widget.model.id;
      final itemInOut = InOutParamModel(
        qtyInOut: _qtyInOut,
        date: DateTime.now().toIso8601String(),
        status: actionType.toLowerCase(),
        warehouseItemId: Id,
        aktor: "cikiw",
      );

      await inOutService.addItemInOut(itemInOut);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action successful!')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionListScreen(),
        ),
      );
    } catch (e) {
      print("Error: $e");
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
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (_qtyInOut > 1) {
                                    _qtyInOut--;
                                    _qtyInOutController.text =
                                        _qtyInOut.toString();
                                  }
                                });
                              },
                            ),
                            Expanded(
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
                                  _qtyInOutController.text =
                                      _qtyInOut.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<int>(
                        value: _selectedAction,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: const Text("Barang Masuk",
                                style: TextStyle(fontSize: 16)),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: const Text("Barang Keluar",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedAction = value!;
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
                          const SnackBar(
                              content: Text('Please select an action')),
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
              "${widget.model.id}",
            ),
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
