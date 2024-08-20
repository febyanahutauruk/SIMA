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
          .where((warehouse) => warehouse.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      if (filteredWarehouses.isNotEmpty &&
          filteredWarehouses[0].latitude != null &&
          filteredWarehouses[0].longitude != null &&
          searchController.text.isNotEmpty) {
        mapController.move(
            LatLng(filteredWarehouses[0].latitude!,
                filteredWarehouses[0].longitude!),
            10.0);
      }
    });
  }

  void _onWarehouseSelected(Warehouse warehouse) {
    mapController.move(LatLng(warehouse.latitude!, warehouse.longitude!), 10.0);
    searchController.clear();
    setState(() {
      filteredWarehouses = [];
    });
  }

  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, '/Inventory');
          },
        ),
        title: Text(
          'Maps',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
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

          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(-6.21462, 106.84513),
                  initialZoom: 4.5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: warehouses
                        .where((warehouse) =>
                            warehouse.longitude != null &&
                            warehouse.latitude != null)
                        .map((warehouse) {
                      return Marker(
                        point:
                            LatLng(warehouse.latitude!, warehouse.longitude!),
                        width: 80.0,
                        height: 80.0,
                        child: GestureDetector(
                          onTap: () {
                            mapController.move(
                                LatLng(
                                    warehouse.latitude!, warehouse.longitude!),
                                15.0);
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  padding: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.remove,
                                                size: 40, color: Colors.grey),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              warehouse.name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 18),
                                            Text(
                                              warehouse.address,
                                              style: GoogleFonts.poppins(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: _warehouseMarker(),
                        ),
                      );
                    }).toList(),
                  ),
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
      Icons.home_rounded,
      color: Colors.teal,
      size: 40.0,
    );
  }

  Widget _buildSearchBar() {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for a warehouse...',
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
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
        color: Colors.white,
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
