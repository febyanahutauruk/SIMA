import 'package:flutter/material.dart';

// void main() {
//   runApp(InventoryManagementApp());
// }

// class InventoryManagementApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ItemListScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class TransactionList extends StatelessWidget {
  static const String routename = "/ListItem";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Item',
          style: TextStyle(color: Colors.teal),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Furniture', Colors.white),
                  _buildCategoryButton('Alat Tulis', Colors.white),
                  _buildCategoryButton('Elektronik', Colors.white),
                  _buildCategoryButton('Perkapalan', Colors.white),
                ],
              ),
            ),
            SizedBox(height: 15),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildListItem(context, 'Sverom chair', '234', 'assets/image/image.png'),
                  _buildListItem(context, 'Sverom chair', '500', 'assets/image/sofa merah.png'),
                  _buildListItem(context, 'Sverom chair', '123', 'assets/image/tv.jpg'),
                  _buildListItem(context, 'Sverom chair', '1400','assets/image/printer.png'),
                  _buildListItem(context, 'Sverom chair', '300', 'assets/image/Product pic.png'),
                  _buildListItem(context, 'Sverom chair', '780', 'assets/image/printer.jpg'),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, String price, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              price: price,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    price,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;

  DetailScreen({required this.title, required this.price, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(color: Colors.teal),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(imagePath, height: 200),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '09/07/2024',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.infinity,
                              height: 352,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: () {
                                          },
                                        ),
                                        Container(
                                          width: 60,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle),
                                          onPressed: () {
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    child: Text('Submit',
                                    style: TextStyle(color:Colors.white)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Action',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Detail',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildDetailRow('Name Product', title),
                _buildDetailRow('Kode Product', 'LK091827'),
                _buildDetailRow('Kategori', 'Furniture'),
                _buildDetailRow('Quantity', '120'),
                _buildDetailRow('Location', 'Gudang 123'),
                _buildDetailRow('Description', 'Deskripsi Barang'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
