import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sima/controllers/form/update_data_controller.dart';
import 'package:sima/models/form/update_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/services/item/item_service.dart';

class UpdateDataScreen extends StatefulWidget {
  final UpdateDataModel item;

  UpdateDataScreen({required this.item});

  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final UpdateDataController _updateDataController = UpdateDataController();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late Future<List<Category>> _categoryListFuture;

  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _idController.text = widget.item.id?.toString() ?? '';
    _nameController.text = widget.item.name;
    _codeController.text = widget.item.code;
    _descriptionController.text = widget.item.description ?? '';
    _usernameController.text = widget.item.createdBy;
    _categoryListFuture = ItemService().fetchCategoryList();

    if (widget.item.id != null) {
      fetchImage(widget.item.id!, true).then((file) {
        setState(() {
          _imageFile = file;
        });
      }).catchError((e) {
        print('Error fetching image: $e');
      });
    }
  }

  Future<File?> fetchImage(int id, bool isStream) async {
    final url = 'https://apistrive.pertamina-ptk.com/api/Items/$id/Image'; // Replace with your API URL
    final response = await http.get(
      Uri.parse('$url?id=$id&isStream=True'),
    );

    if (response.statusCode == 200) {
      // Assuming you get the image in the response body
      final bytes = response.bodyBytes;
      final file = File('${Directory.systemTemp.path}/image_$id.jpg'); // Temporary file
      await file.writeAsBytes(bytes);
      return file;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _submit() async {
    try {
      final item = UpdateDataModel(
        id: int.tryParse(_idController.text) ?? 0, // Ensure ID is an int
        name: _nameController.text,
        code: _codeController.text,
        category: _selectedCategory?.id,
        description: _descriptionController.text,
        createdBy: _usernameController.text,
        fileUploads: _imageFile,
      );

      await _updateDataController.updateItem(item);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item updated successfully!')),
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ItemListScreen()));
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, '/Inventory');
          },
        ),
        backgroundColor: Colors.teal,
        title: const Text(
          'Update Item',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
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
            )
            ,
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
                    decoration: InputDecoration(labelText: 'Category',border: OutlineInputBorder()),
                    value: _selectedCategory,
                    onChanged: (Category? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    items: snapshot.data!.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
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
