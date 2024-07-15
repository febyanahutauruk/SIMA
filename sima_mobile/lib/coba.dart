import 'package:flutter/material.dart';

void main() {
  runApp(SimaApp());
}

class SimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMA',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo-lg-transparant 2.png',
                  height: 50,
                ),
                SizedBox(width: 8)
              ],
            ),
            Text(
              'Solusi Inventaris Pintar untuk Bisnis Modern!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            ManagementFeature(
              title: 'Assets Management',
              onTap: () {
                print('Assets Management Tapped');
              },
            ),
            ManagementFeature(
              title: 'Inventory Management',
              onTap: () {
                print('Inventory Management Tapped');
              },
            ),
            SizedBox(height: 20),
            Text(
              'General',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GeneralFeature(
                  icon: Icons.dataset,
                  title: 'Master Data Aset',
                ),
                GeneralFeature(
                  icon: Icons.qr_code,
                  title: 'Barcode Aset',
                ),
                GeneralFeature(
                  icon: Icons.inventory,
                  title: 'Master Data Inventory',
                ),
                GeneralFeature(
                  icon: Icons.history,
                  title: 'History Inventory',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        ],
      ),
    );
  }
}

class ManagementFeature extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ManagementFeature({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralFeature extends StatelessWidget {
  final IconData icon;
  final String title;

  const GeneralFeature({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 50,
          color: Colors.teal,
        ),
        SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}