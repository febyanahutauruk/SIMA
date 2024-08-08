import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/dashboard/dashboard_model.dart';
import 'package:sima/models/dashboard/dashboard_param_model.dart';

class DashboardItemService {
  Future<DashboardItemResponseModel> getDashboardItemData(DashboardPaginationParamModel params) async {
    try {
      var url = Uri.https("apistrive.pertamina-ptk.com", "api/ItemInOut/Sum");

      var body = jsonEncode(params.warehouseName ?? '');

      print("Request URL: $url");
      print("Request Body: $body");

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return DashboardItemResponseModel.fromJson(jsonResponse);
      } else {
        print("Failed to load dashboard item data, status code: ${response.statusCode}");
        throw Exception('Failed to load dashboard item data');
      }
    } catch (e) {
      print("Error in service: ${e.toString()}");
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<List<String>> fetchWarehouseList() async {
    final response = await http.get(Uri.parse('https://apistrive.pertamina-ptk.com/Warehouses'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<String>.from(data.map((item) => item['name']));
    } else {
      throw Exception('Failed to load warehouses');
    }
  }
}
