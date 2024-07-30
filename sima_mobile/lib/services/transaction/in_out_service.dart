import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/transaction_pagination_model.dart';

class InOutService {
  final String baseUrl = 'https://apistrive.pertamina-ptk.com/api';

  Future<TransactionPaginationModel?> addItemInOut(TransactionPaginationModel model) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ItemInOut/Add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return TransactionPaginationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add item in/out');
    }
  }
}
