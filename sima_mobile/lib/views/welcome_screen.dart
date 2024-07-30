import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sima/views/widgets/icon_home.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _gotohome() async {
  await Future.delayed(const Duration(milliseconds: 1500), () {
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
        const Text(
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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ClipPath(
          clipper: BottomRoundedClipper(),
          child: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 200,
            backgroundColor: Colors.teal,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/image/logo-lg-transparant 2.png',
                  width: 250,
                ),
                const SizedBox(height: 0),
                Text(
                  'Solusi Inventaris Pintar untuk Bisnis Modern!',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome, Let\'s Start!',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/image/pertaminaPTK.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/image/gudang123.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/image/gudang PTK.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Management Feature',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.blueGrey.shade50,
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                title: Text('Assets Management',
                  style: GoogleFonts.poppins(fontSize: 14,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500),),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.teal, size: 14,),
                onTap: () {
                  Navigator.pushNamed(context, '/assets');
                },
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.blueGrey.shade50,
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                title: Text('Inventory Management',
                  style: GoogleFonts.poppins(fontSize: 14,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500),),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.teal, size: 14,),
                onTap: () {
                  Navigator.pushNamed(context, '/Inventory');
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'General',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureItem(Icons.landscape_rounded, 'Master Data Asset', context, ''),
                _buildFeatureItem(Icons.barcode_reader, 'Barcode Asset', context, ''),
                _buildFeatureItem(Icons.home_rounded, 'Master Data Inventory', context, ''),
                _buildFeatureItem(Icons.history_rounded, 'History Inventory', context, ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, BuildContext context,
      String routename) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routename);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Column( // Use a Column to position icon and text vertically
            mainAxisSize: MainAxisSize.min,
            // To avoid Column taking full height
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 4), // Spacing between icon and text
              SizedBox(
                width: 70, // Slightly smaller width for text
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(0, size.height, 30, size.height);
    path.lineTo(size.width - 30, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}


