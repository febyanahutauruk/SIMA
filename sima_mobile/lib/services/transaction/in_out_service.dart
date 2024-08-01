import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/in_out_model.dart';

class InOutService {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/api/ItemInOut/Add';

  Future<void> addItemInOut(InOutModel item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      print("success");
    } else {
      print("gagal: ${response.body}");
    }
  }
}
