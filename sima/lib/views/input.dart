import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: DetailItemScreen(),
  ));
}

class DetailItemScreen extends StatefulWidget {
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _idBarangController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Text(
          'Detail Item',
          style: TextStyle(color: Colors.teal),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'image/tv.jpg',
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal, 
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.teal),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.delete),
                        label: Text(''),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: _namaBarangController,
              decoration: InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _idBarangController,
              decoration: InputDecoration(
                labelText: 'ID Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _kategoriController,
                    decoration: InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _stokController,
                    decoration: InputDecoration(
                      labelText: 'Stok',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            TextField(
              controller: _areaController,
              decoration: InputDecoration(
                labelText: 'Area',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Nama Barang: ${_namaBarangController.text}');
                  print('ID Barang: ${_idBarangController.text}');
                  print('Kategori: ${_kategoriController.text}');
                  print('Stok: ${_stokController.text}');
                  print('Area: ${_areaController.text}');
                  print('Deskripsi: ${_deskripsiController.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
