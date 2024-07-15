import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ItemScreen(),
  ));
}
class ItemScreen extends StatelessWidget {
  final List<Map<String, String>> items = List.generate(5, (index) {
    return {
      'nama': 'Enduro 4T',
      'kode': 'KS01',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Item',
          style: TextStyle(color: Colors.teal),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), backgroundColor: Colors.teal,
                    padding: EdgeInsets.all(10), 
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(Icons.filter_list),
                  label: Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal, 
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.teal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(items[index]['nama']!),
                      subtitle: Text(items[index]['kode']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // View action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Lihat', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Delete action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Icon(Icons.delete, color: Colors.white),
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
                TextButton(
                  onPressed: () {
                  },
                  child: Text('Previous'),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  ),
                  child: Text('1'),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                  ),
                  child: Text('2'),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                  ),
                  child: Text('3'),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

