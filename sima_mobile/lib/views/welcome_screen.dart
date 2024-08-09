import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima/services/News/news_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _gotohome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    });
  }

  @override
  void initState() {
    _gotohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation :0.0,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        toolbarHeight: 200,
        backgroundColor: Colors.teal,
        flexibleSpace: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 85),
                child: Image.asset(
                  'assets/image/logo-lg-transparant 2.png',
                  width: 250,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'Solusi Inventaris Pintar untuk Bisnis Modern!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
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
                title: Text(
                  'Assets Management',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.teal,
                  size: 14,
                ),
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
                title: Text(
                  'Inventory Management',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.teal,
                  size: 14,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/Inventory');
                },
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'What\'s New!',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCarousel(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/image/Logo_PTK.png',
                  width: 200,
                  height: 200,)
              ],

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return FutureBuilder<List<String>>(
      future: _newsService.fetchNewsImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading images'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No images available'));
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: snapshot.data!.map((imageUrl) {
              return Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image/placeholder_image.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}


