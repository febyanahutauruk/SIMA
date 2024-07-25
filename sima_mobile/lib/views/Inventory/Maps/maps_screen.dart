import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sima/services/map/map_service.dart';
import 'package:sima/models/map/map_model.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<List<Warehouse>> futureWarehouses;
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    futureWarehouses = ApiService().fetchWarehouses();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Map'),
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

          List<Marker> markers = snapshot.data!
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

          return FlutterMap(
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
          );
        },
      ),
    );
  }

  Widget _warehouseMarker() {
    return Icon(
      Icons.location_on,
      color: Colors.red,
      size: 40.0,
    );
  }
}
