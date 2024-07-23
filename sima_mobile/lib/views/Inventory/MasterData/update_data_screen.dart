import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sima/controllers/form/update_data_controller.dart';
import 'package:sima/models/form/item_form_model.dart';
import 'package:sima/controllers/form/item_form_controllers.dart';
import 'package:sima/models/form/update_data_model.dart';

class UpdateDataScreen extends StatefulWidget {
  final UpdateDataModel item;

  UpdateDataScreen({required this.item});

  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final UpdateDataController _UpdateDataController = UpdateDataController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.item.name;
    _codeController.text = widget.item.code;
    _descriptionController.text = widget.item.description ?? '';
    _usernameController.text = widget.item.createdBy;
    _selectedCategoryId = widget.item.category;
  //   if (widget.item.fileUploads != null) {
  //     _imageFile = File(widget.item.fileUploads!);
  //   }
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
      final item = UpdateDataModel(
        name: _nameController.text,
        code: _codeController.text,
        category: _selectedCategoryId,
        description: _descriptionController.text,
        createdBy: _usernameController.text,
        fileUploads: _imageFile,
      );

      await _UpdateDataController.updateItem(item);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item updated successfully!')));

      Navigator.of(context).pop();
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update item: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D9DA),
        title: const Text(
          'Update Item',
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: <String>['1', '2', '3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                });
              },
              value: _selectedCategoryId,
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
                child: const Text(
                  'Update',
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
