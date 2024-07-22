import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sima/views/widgets/icon_home.dart';


// void main() {
//   runApp(MaterialApp(
//     home: new WelcomeScreen(),
//     debugShowCheckedModeBanner: false,
//     routes: <String,WidgetBuilder>{
//       '/WelcomeScreen' : (BuildContext context) => new WelcomeScreen(),
//       '/HomeScreen' : (BuildContext context) => new HomeScreen(),
//       '/Inventory' : (BuildContext context) => new HomeScreenInventory(),
//     }
//   ));
// }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _gotohome() async {
  await Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushNamed(context, '/HomeScreen');
  }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    _gotohome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/HomeScreen');
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.arrow_right),
      ),

      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/image/logo-lg-transparant 2.png',
          width: 250,
        ),
        const SizedBox(height: 0),
        Text(
          'Solusi Inventaris Pintar untuk Bisnis Modern!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
            toolbarHeight: 200,
            backgroundColor: Colors.teal,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo-lg-transparant 2.png',
                  width: 250,
                ),
                SizedBox(height: 0),
                Text(
                  'Solusi Inventaris Pintar untuk Bisnis Modern!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome, Let\'s Start!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/image/pertaminaPTK.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/image/gudang123.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/image/gudang PTK.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Management Feature',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                title: Text('Assets Management'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, '/assets');
                },
              ),
            ),
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                title: Text('Inventory Management'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, '/Inventory');
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'General',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 12),
                  IconHomeWidget(routename: '/WelcomeScreen', lable: 'Master Data Asset', icons: 'assets.png'),
                  IconHomeWidget(routename: '/manageAssets', lable: 'Barcode Assets', icons: 'qr.png'),
                  IconHomeWidget(routename: '/ItemListScreen', lable: 'Master Data Inventory', icons: 'dataBarang.png'),
                  IconHomeWidget(routename: '/History', lable: 'History Inventory', icons: 'history.png'),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.business),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/manageAssets');
                  //       },
                  //     ),
                  //     Text('Barcode Asset'),
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.category),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/manageCategories');
                  //       },
                  //     ),
                  //     Text('Master Data Inventory'),
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.history),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/inventoryHistory');
                  //       },
                  //     ),
                  //     Text('Inventory History'),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

