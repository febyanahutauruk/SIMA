import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final TextEditingController _searchController = TextEditingController();

  final LatLng _initialPosition = const LatLng(-6.200000, 106.816666); 
  LatLng _currentPosition = const LatLng(-6.200000, 106.816666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: _currentPosition,
              ),
            },
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Telusuri di sini',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 15, top: 15),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchLocation,
                    iconSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _searchLocation() async {
    String searchAddress = _searchController.text;
    if (searchAddress.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(searchAddress);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          LatLng newPosition = LatLng(location.latitude, location.longitude);

          mapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: newPosition, zoom: 14.0),
          ));

          setState(() {
            _currentPosition = newPosition;
          });
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
