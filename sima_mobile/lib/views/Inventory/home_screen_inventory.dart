import 'package:flutter/material.dart';
import 'package:sima/views/Inventory/MasterData/item_list_screen.dart';
import 'package:sima/views/welcome_screen.dart';

// void main(){
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomeScreenInventory(),
//   ));
// }

class HomeScreenInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/WelcomeScreen');
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mobina Sadat',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Bogor Warehouse',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Stock',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Warehouse List'),
                          trailing: Icon(Icons.arrow_drop_down),
                          onTap: () {},
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildStockItem(Icons.arrow_forward, '1520 Item', 'Item In', Colors.teal),
                      _buildStockItem(Icons.warning, '18 Item', 'Low Stock', Colors.orange),
                      _buildStockItem(Icons.arrow_back, '20 Item', 'Item Out', Colors.red),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Features',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeatureItem(Icons.list, 'Daftar Barang', context, '/TransactionList'),
                  _buildFeatureItem(Icons.map, 'Maps', context,  '/Maps'),
                  _buildFeatureItem(Icons.history, 'History', context, '/History'),
                  _buildFeatureItem(Icons.save, 'Item', context, '/ItemListScreen'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockItem(IconData icon, String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, BuildContext context, String routename) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListScreen()));
        Navigator.pushNamed(context, '$routename');
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}

