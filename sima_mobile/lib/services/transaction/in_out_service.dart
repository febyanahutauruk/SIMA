import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/in_out_model.dart';

class InOutService {
  Future<void> addItemInOut(InOutParamModel itemInOut) async {
    final String _baseUrl = "https://apistrive.pertamina-ptk.com/api";
    final requestJson = jsonEncode(itemInOut.toJson());

    // Log the request JSON
    print("Request JSON baru: $requestJson");

    final response = await http.post(
      Uri.parse("$_baseUrl/ItemInOut/Add"),
      headers: {
        "Content-Type": "application/json",
      },
      body: requestJson,
    );

    if (response.statusCode != 200) {
      print("Failed to add item in/out. Status code: ${response.statusCode}, Error: ${response.body}");
      throw Exception("Failed to add item in/out. Status code: ${response.statusCode}, Error: ${response.body}");
    }

    print("Success: ${response.body}");
  }
}
