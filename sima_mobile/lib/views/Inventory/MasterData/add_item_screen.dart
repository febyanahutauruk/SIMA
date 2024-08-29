import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sima/models/form/item_form_model.dart';
import 'package:sima/controllers/form/item_form_controllers.dart';
import 'package:sima/services/item/item_service.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';

class InputItemScreen extends StatefulWidget {
  const InputItemScreen({super.key});

  @override
  _InputItemScreenState createState() => _InputItemScreenState();
}

class _InputItemScreenState extends State<InputItemScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final ItemController _itemController = ItemController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late Future<List<Category>> _categoryListFuture;

  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _categoryListFuture = ItemService().fetchCategoryList();
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
                  color: Colors.black, fontWeight: FontWeight.w500),
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
            child: Text(
              "Cancel",
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
              Navigator.of(context).pop();
              await _submit();
            },
            child: Text(
              "Confirm",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    try {
      final item = ItemFormModel(
        name: _nameController.text,
        code: _codeController.text,
        category: _selectedCategory?.id,
        description: _descriptionController.text,
        createdBy: "aufar",
        fileUploads: _imageFile,
      );

      final response = await _itemController.addItem(item);

      _nameController.clear();
      _codeController.clear();
      _descriptionController.clear();
      _usernameController.clear();

      setState(() {
        _imageFile = null;
        _selectedCategory = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added successfully!')));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ItemListScreen()));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add item: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, '/ItemListScreen');
          },
        ),
        title: Text(
          "Add New Item",
          style: GoogleFonts.poppins(color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Select Image Source'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Camera'),
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Gallery'),
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: _imageFile == null
                    ? const Icon(
                  Icons.image,
                  size: 200,
                  color: Colors.grey,
                )
                    : Image.file(
                  _imageFile!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: "Product Code",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<List<Category>>(
              future: _categoryListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load categories'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories available'));
                } else {
                  return DropdownButtonFormField<Category>(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(labelText: 'Category',border: OutlineInputBorder(),labelStyle: GoogleFonts.poppins(),),
                    value: _selectedCategory,
                    onChanged: (Category? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    items: snapshot.data!.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name,
                            style: GoogleFonts.poppins())
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  );
                }
              },
            ),

            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  if (_nameController.text.trim().isEmpty ||
                      _codeController.text.trim().isEmpty ||
                      _selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          'Please complete all fields before submitting.')),
                    );
                  } else {
                    _showConfirmationDialog(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16.0),
                ),
                child:  Text('Submit',
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
