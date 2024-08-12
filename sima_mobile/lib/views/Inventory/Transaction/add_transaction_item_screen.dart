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

class _InputTransactionItemScreenState
    extends State<InputTransactionItemScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final AddTransactionItemFormControllers _addTransactionItemFormControllers =
      AddTransactionItemFormControllers();
  final TextEditingController _aktorController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _minQtyController = TextEditingController();
  final TextEditingController _informationController = TextEditingController();

  late Future<List<Items>> _itemListFuture;
  late Future<List<Warehouses>> _warehouseListFuture;

  Items? _selectedItems;
  Warehouses? _selectedWarehouses;
  String? _selectedOwnership;

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
    // Validate the input fields
    if (_selectedWarehouses == null ||
        _selectedItems == null ||
        _selectedOwnership == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields before submitting.')),
      );
      return; // Do not proceed if validation fails
    }

    try {
      final item = AddTransactionItemModel(
        warehouseId: _selectedWarehouses?.id,
        itemId: _selectedItems?.id,
        aktor: "feby",
        qty: int.parse(_qtyController.text),
        minQty: int.parse(_minQtyController.text),
        ownership: _selectedOwnership,
        information: _informationController.text,
      );
      final response = await _addTransactionItemFormControllers.addItem(item);

      // Clear input fields after successful submission
      _aktorController.clear();
      _qtyController.clear();
      _minQtyController.clear();
      _informationController.clear();

      setState(() {
        _selectedWarehouses = null;
        _selectedItems = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added successfully!')),
      );
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TransactionListScreen()));

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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, '/TransactionList');
          },
        ),
        title: Text(
          "Transaction",
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
                      labelStyle: GoogleFonts.poppins(),
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
                        child: Text(item.name, 
                          style: GoogleFonts.poppins()),
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
                      labelStyle: GoogleFonts.poppins(),
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
                        child:
                            Text(warehouse.name, 
                            style: GoogleFonts.poppins()),
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(),
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(),
                labelText: "Minimal Quantity",
              ),
            ),
            const SizedBox(height: 24.0),
            InputDecorator(
              decoration: InputDecoration(
                labelStyle: GoogleFonts.poppins(),
                labelText: 'Ownership',
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedOwnership,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOwnership = newValue;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  dropdownColor: Colors.white,
                  hint: Text(
                    "Ownership",
                    style: GoogleFonts.poppins(),
                  ),
                  items: <String>['Milik', 'Sewa'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.teal),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _informationController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(),
                labelText: "Information",
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16.0),
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
