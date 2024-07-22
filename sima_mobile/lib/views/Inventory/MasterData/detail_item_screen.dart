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
             const TextField( decoration: InputDecoration(labelText: "Name Product")),
             const TextField( decoration: InputDecoration(labelText: "Code Product")),
             const TextField( decoration: InputDecoration(labelText: "Category")),
             const TextField( decoration: InputDecoration(labelText: "Quantity")),
             const TextField( decoration: InputDecoration(labelText: "Location")),
             const TextField( decoration: InputDecoration(labelText: "Deskripsi")),
             const SizedBox(height: 100),
             ElevatedButton(onPressed: () {}, child: const Text('Submit'))
           ],
         ),
       ),
    );
  }
}


