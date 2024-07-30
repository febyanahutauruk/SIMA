import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sima/models/form/item_form_model.dart';
import 'package:sima/controllers/form/item_form_controllers.dart';
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
  
  int? _selectedCategoryId;

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
      final item = ItemFormModel(
        name: _nameController.text,
        code: _codeController.text,
        category: _selectedCategoryId,
        description: _descriptionController.text,
        createdBy: _usernameController.text,
        fileUploads: _imageFile,
      );

      final response = await _itemController.addItem(item);

      _nameController.clear();
      _codeController.clear();
      _descriptionController.clear();
      _usernameController.clear();

      setState(() {
        _imageFile = null;
        _selectedCategoryId = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added successfully!')));
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => ItemListScreen()),
      );
    } catch (e) {
      print(e); 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add item: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D9DA),
        title: const Text(
          'Add New Item',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.teal),
        ),
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
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: "Product Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: <int>[1, 2, 3]
                  .map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
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
                child: const Text('Submit',
                style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
