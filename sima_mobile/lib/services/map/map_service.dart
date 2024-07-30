import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/map/map_model.dart';

class ApiService {
  Future<List<Warehouse>> fetchWarehouses() async {
    final uri = Uri.parse('https://apistrive.pertamina-ptk.com/Warehouses/Maps');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'code': '',
      'name': '',
      'address': '',
      'locationName': '',
    });

    final response = await http.post(uri, headers: headers, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        print('Decoded data: $data');

        if (data['isSuccess'] == true) {
          List<dynamic> warehouseData = data['data'];
          return warehouseData
              .map((json) => Warehouse.fromJson(json))
              .toList();
        } else {
          throw Exception('API returned isSuccess false: ${data['errorMsg']}');
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception('Failed to decode JSON');
      }
    } else {
      throw Exception('Failed to load warehouses with status code ${response.statusCode}');
    }
  }
}
