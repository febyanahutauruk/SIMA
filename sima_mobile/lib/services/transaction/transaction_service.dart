import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/transaction_param_model.dart';
import 'package:sima/models/transaction/transaction_base_pagination_model.dart';

class TransactionService {
  Future<TransactionPaginationResponseModel> getPaginationTransaction(TransactionParamModel param) async {
    try {
      var url = Uri.https("apistrive.pertamina-ptk.com", "WarehouseItem/DTMobile");

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(param.toJson()),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return TransactionPaginationResponseModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch data: ${response.statusCode} - ${response.body}");
        return TransactionPaginationResponseModel(
          data: [],
          offset: param.offset,
          isNext: false,
        );
      }
    } catch (e) {
      throw Exception("Error fetching data: ${e.toString()}");
    }
  }

Future<void> addItemInOut(TransactionParamModel itemInOut) async {
    final String _baseUrl = "https://apistrive.pertamina-ptk.com/api";
    final requestJson = jsonEncode(itemInOut.toJson());

    // Log the request JSON
    print("Request JSON: $requestJson");

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

  final String _baseUrl = 'https://apistrive.pertamina-ptk.com/WarehouseItem/DTMobile';

  Future<void> fetchTransactions(TransactionParamModel paramModel) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/transactions'), // Replace with your API endpoint
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(paramModel.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Response: ${response.body}');
    } else {
      // Handle error response
      throw Exception('Failed to load transactions');
    }
  }
}
