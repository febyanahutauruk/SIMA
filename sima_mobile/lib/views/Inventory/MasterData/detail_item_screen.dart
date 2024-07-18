import "package:flutter/material.dart";

// void main() {
//   runApp(MaterialApp(
//     home: DetailItemScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class DetailItemScreen extends StatefulWidget {
  const DetailItemScreen({super.key});

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Item'),
        backgroundColor: Colors.teal,
      ),
       body: SingleChildScrollView(
         child: Column(
           children: [
             TextField( decoration: const InputDecoration(labelText: "Name Product")),
             TextField( decoration: const InputDecoration(labelText: "Code Product")),
             TextField( decoration: const InputDecoration(labelText: "Category")),
             TextField( decoration: const InputDecoration(labelText: "Quantity")),
             TextField( decoration: const InputDecoration(labelText: "Location")),
             TextField( decoration: const InputDecoration(labelText: "Deskripsi")),
             SizedBox(height: 100),
             ElevatedButton(onPressed: () {}, child: const Text('Submit'))
           ],
         ),
       ),
    );
  }
}


