import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sima/services/map/map_service.dart';
import 'package:sima/models/map/map_model.dart';
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<List<Warehouse>> futureWarehouses;
  late MapController mapController;
  List<Warehouse> warehouses = [];
  List<Warehouse> filteredWarehouses = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureWarehouses = ApiService().fetchWarehouses();
    mapController = MapController();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredWarehouses = warehouses
          .where((warehouse) => warehouse.name.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onWarehouseSelected(Warehouse warehouse) {
    mapController.move(LatLng(warehouse.latitude!, warehouse.longitude!), 15.0);
    searchController.clear(); // Clear the search input after selecting a warehouse
    setState(() {
      filteredWarehouses = []; // Clear the suggestions after selecting a warehouse
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pushNamed(context, '/Inventory');
          },
        ),
        title: Text('Warehouse Map',textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),),
      ),
      body: FutureBuilder<List<Warehouse>>(
        future: futureWarehouses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No warehouses found'));
          }

          warehouses = snapshot.data!;
          if (searchController.text.isEmpty) {
            filteredWarehouses = warehouses;
          }

          List<Marker> markers = warehouses
              .where((warehouse) =>
          warehouse.longitude != null && warehouse.latitude != null)
              .map((warehouse) {
            return Marker(
              point: LatLng(warehouse.latitude!, warehouse.longitude!),
              width: 80.0,
              height: 80.0,
              child: _warehouseMarker(),
            );
          }).toList();

          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(-6.21462, 106.84513), // Coordinates for Indonesia
                  initialZoom: 10.0, // Adjust zoom level as needed
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                child: _buildSearchBar(),
              ),
              if (searchController.text.isNotEmpty) _buildSearchResults(),
            ],
          );
        },
      ),
    );
  }

  Widget _warehouseMarker() {
    return Icon(
      Icons.home,
      color: Colors.teal,
      size: 40.0,
    );
  }

  Widget _buildSearchBar() {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for a warehouse...',
          hintStyle: TextStyle(color: Colors.teal),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          prefixIcon: Icon(Icons.search, color: Colors.teal,),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Positioned(
      top: 72.0,
      left: 16.0,
      right: 16.0,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredWarehouses.length,
          itemBuilder: (context, index) {
            final warehouse = filteredWarehouses[index];
            return ListTile(
              title: Text(warehouse.name),
              subtitle: Text(warehouse.address),
              onTap: () {
                _onWarehouseSelected(warehouse);
              },
            );
          },
        ),
      ),
    );
  }
}
