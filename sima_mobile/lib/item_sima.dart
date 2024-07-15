import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: Icon(Icons.add),
              label: Text('Tambah'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daftar Item'),
                Row(
                  children: [
                    Text('Show '),
                    DropdownButton<int>(
                      value: 10,
                      items: [10, 20, 30].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                      },
                    ),
                    Text(' entries'),
                    SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.filter_list),
                      label: Text('Filter'),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Enduro 4T'),
                      subtitle: Text('ID Barang: KS01'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            },
                            child: Text('Lihat'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, 
                              foregroundColor: Colors.white, 
                            ),
                            child: Text('Hapus'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Previous'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('1'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('2'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('3'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.teal,
        onTap: (index) {
        },
      ),
    );
  }
}
