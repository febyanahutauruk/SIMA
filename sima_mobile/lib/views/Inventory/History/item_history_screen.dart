import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D9DA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey, backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_list),
                      SizedBox(width: 5),
                      Text('Filter'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  SectionHeader(title: 'Bulan Ini'),
                  HistoryItem(
                    icon: Icons.arrow_downward,
                    iconColor: Colors.teal,
                    title: 'Enduro 4T',
                    subtitle: 'SPOB1002G5',
                    quantity: '+ 500',
                    status: 'In',
                    statusColor: Colors.teal,
                  ),
                  HistoryItem(
                    icon: Icons.arrow_upward,
                    iconColor: Colors.red,
                    title: 'Enduro 4T',
                    subtitle: 'SPOB1002G5',
                    quantity: '- 50',
                    status: 'Out',
                    statusColor: Colors.red,
                  ),
                  HistoryItem(
                    icon: Icons.arrow_downward,
                    iconColor: Colors.teal,
                    title: 'Enduro 4T',
                    subtitle: 'SPOB1002G5',
                    quantity: '+ 500',
                    status: 'In',
                    statusColor: Colors.teal,
                  ),
                  SectionHeader(title: 'Juni 2024'),
                  HistoryItem(
                    icon: Icons.arrow_upward,
                    iconColor: Colors.red,
                    title: 'Enduro 4T',
                    subtitle: 'SPOB1002G5',
                    quantity: '- 50',
                    status: 'Out',
                    statusColor: Colors.red,
                  ),
                  HistoryItem(
                    icon: Icons.arrow_downward,
                    iconColor: Colors.teal,
                    title: 'Enduro 4T',
                    subtitle: 'SPOB1002G5',
                    quantity: '+ 500',
                    status: 'In',
                    statusColor: Colors.teal,
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

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String quantity;
  final String status;
  final Color statusColor;

  HistoryItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 32,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(subtitle),
                Text(
                  'Qty: $quantity',
                  style: TextStyle(color: iconColor),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
