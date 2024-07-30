import 'package:flutter/foundation.dart';
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
  int? _selectedAction; // To store selected action
  int _quantity = 1; // Default quantity
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantityController.text = _quantity.toString(); // Initialize the controller
  }

  @override
  void dispose() {
    _quantityController.dispose(); 
    super.dispose();
  }

  void _updateQuantity(String value) {
    int? quantity = int.tryParse(value);
    if (quantity != null && quantity > 0) {
      setState(() {
        _quantity = quantity;
      });
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Action"),
        content: Text(
          _selectedAction == 1
              ? "Are you sure you want to add $_quantity items?"
              : "Are you sure you want to remove $_quantity items?",
        ),
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
        qty: _quantity,
      );

      await transactionService.addItemInOut(itemInOut);

      setState(() {
        if (_selectedAction == 1) {
          widget.model.qty += _quantity;
        } else {
          widget.model.qty -= _quantity;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Action successful!')),
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
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: "Action",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Barang Masuk")),
                  DropdownMenuItem(value: 2, child: Text("Barang Keluar")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAction = value;
                  });
                },
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
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                              _quantityController.text = _quantity.toString();
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          onChanged: _updateQuantity,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                            _quantityController.text = _quantity.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedAction != null) {
                        Navigator.of(context).pop();
                        _showConfirmationDialog(context);
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.itemName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.model.fileUrl ?? 'https://via.placeholder.com/200',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.model.itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.model.itemCategory,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantity: ${widget.model.qty}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Warehouse: ${widget.model.warehouseName}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${widget.model.status}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff),
        onPressed: _showBottomSheet,
        label: const Text("Adjust Quantity & Submit"),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
