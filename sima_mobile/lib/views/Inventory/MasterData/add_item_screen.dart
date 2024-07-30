import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// void main() {
//   runApp(MaterialApp(
//     home: InputItemScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class InputItemScreen extends StatefulWidget {
  const InputItemScreen({super.key});

  @override
  _InputItemScreenState createState() => _InputItemScreenState();
}

class _InputItemScreenState extends State<InputItemScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
