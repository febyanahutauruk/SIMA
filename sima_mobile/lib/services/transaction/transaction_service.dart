import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/transaction_param_model.dart';
import 'package:sima/models/transaction/transaction_base_pagination_model.dart';

class TransactionService {
  final String _baseUrl = 'https://apistrive.pertamina-ptk.com';

  /// Fetch paginated transactions
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

  /// Fetch list of categories
  Future<List<Category>> fetchCategoryList() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/Category'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<Category>.from(data.map((item) => Category.fromJson(item)));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /// Add item in/out transaction
  Future<void> addItemInOut(TransactionParamModel itemInOut) async {
    final String url = "$_baseUrl/api/ItemInOut/Add";
    final requestJson = jsonEncode(itemInOut.toJson());

    // Log the request JSON
    print("Request JSON: $requestJson");

    final response = await http.post(
      Uri.parse(url),
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

  /// Fetch transactions (for a specific use case, update the endpoint accordingly)
  Future<void> fetchTransactions(TransactionParamModel paramModel) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/WarehouseItem/DTMobile/transactions'), // Ensure this endpoint is correct
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

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}
