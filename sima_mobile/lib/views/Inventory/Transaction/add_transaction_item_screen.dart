import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sima/controllers/transaction/add_transaction_item_form_controllers.dart';
import 'package:sima/models/map/map_model.dart';
import 'package:sima/models/transaction/add_transaction_list_model.dart';
import 'package:sima/views/Inventory/Transaction/transaction_list.dart';
import 'package:sima/services/transaction/add_transaction_item_form_service.dart';

class InputTransactionItemScreen extends StatefulWidget {
  const InputTransactionItemScreen({super.key});

  @override
  _InputTransactionItemScreenState createState() =>
      _InputTransactionItemScreenState();
}

class _InputTransactionItemScreenState extends State<InputTransactionItemScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final AddTransactionItemFormControllers _addTransactionItemFormControllers = AddTransactionItemFormControllers();
  final TextEditingController _aktorController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _minQtyController = TextEditingController();

  late Future<List<Items>> _itemListFuture;
  late Future<List<Warehouses>> _warehouseListFuture;

  Items? _selectedItems;
  Warehouses? _selectedWarehouses;

  int? _qty = 0;
  int? _minQty = 0;

  @override
  void initState() {
    super.initState();
    _itemListFuture = AddTransactionItemFormService().fetchItemsList();
    _warehouseListFuture = AddTransactionItemFormService().fetchWarehouseList();
    _qtyController.text = _qty.toString();
    _minQtyController.text = _minQty.toString();
  }

  void _updateQty(String value) {
    int? qty = int.tryParse(value);
    if (qty != null && qty > 0) {
      setState(() {
        _qty = qty;
      });
    }
  }

  void _updateMinQty(String value) {
    int? minQty = int.tryParse(value);
    if (minQty != null && minQty > 0) {
      setState(() {
        _minQty = minQty;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submit() async {
    try {
      final item = AddTransactionItemModel(
        warehouseId: _selectedWarehouses?.id,
        itemId: _selectedItems?.id,
        aktor: _aktorController.text,
        qty: int.parse(_qtyController.text),
        minQty: int.parse(_minQtyController.text),
      );
      final response = await _addTransactionItemFormControllers.addItem(item);

      _aktorController.clear();
      _qtyController.clear();
      _minQtyController.clear();

      setState(() {
        _selectedWarehouses = null;
        _selectedItems = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransactionListScreen()),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, '/ItemListScreen');
          },
        ),
        title: Text(
          "Add New Item",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16.0),
            FutureBuilder<List<Items>>(
              future: _itemListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load items'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items available'));
                } else {
                  return DropdownButtonFormField<Items>(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Items',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedItems,
                    onChanged: (Items? newValue) {
                      setState(() {
                        _selectedItems = newValue;
                      });
                    },
                    items: snapshot.data!.map((Items item) {
                      return DropdownMenuItem<Items>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an item';
                      }
                      return null;
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<List<Warehouses>>(
              future: _warehouseListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load warehouses'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No warehouses available'));
                } else {
                  return DropdownButtonFormField<Warehouses>(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Warehouse',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedWarehouses,
                    onChanged: (Warehouses? newValue) {
                      setState(() {
                        _selectedWarehouses = newValue;
                      });
                    },
                    items: snapshot.data!.map((Warehouses warehouse) {
                      return DropdownMenuItem<Warehouses>(
                        value: warehouse,
                        child: Text(warehouse.name),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a warehouse';
                      }
                      return null;
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _qtyController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _updateQty(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Quantity",
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _minQtyController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _updateMinQty(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Minimal Quantity",
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 16.0),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
