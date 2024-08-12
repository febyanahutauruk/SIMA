import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 10),
            Text(
              "Confirm Action",
              style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to submit this action?",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel",
            style: GoogleFonts.poppins(),
            ),
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
            child: Text(
              "Confirm",
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
            ),
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

      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TransactionListScreen()));
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
      backgroundColor: Colors.white,
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
                  Text(
                    "Adjust Quantity",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
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
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField<int>(
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Action',
                              hintText: 'Choose action',
                            ),
                            hint: const Text('Choose action'),
                            value: _selectedAction,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: [
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  "Item In",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  "Item Out",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedAction = value!;
                              });
                            },
                          ),
                        ),
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
                    child: Text(
                      "Submit",
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
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
    Color statusColor;
    if (widget.model.status == 'Available') {
      statusColor = Colors.green;
    } else if (widget.model.status == 'Unavailable') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.yellow.shade800;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          "Transactions",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, '/TransactionList');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://apistrive.pertamina-ptk.com/WarehouseItem/${widget.model.id}/Image?isStream=true',
                height: 300,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://via.placeholder.com/100',
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.model.itemName}",
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.model.status}",
                            style: GoogleFonts.poppins(fontSize: 14, color: statusColor, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    "Quantity :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.qty}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Min Quantity :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.minQty}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Category :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.itemCategory}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Warehouse :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.warehouseName}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Address :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.address}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ownership :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.ownership}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Information :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.information}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Description :",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.model.description}",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )),
            ),
            const SizedBox(height: 0),
            Center(
              child: ElevatedButton(
                onPressed: _showBottomSheet,
                child: Text(
                  "Add Action",
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
