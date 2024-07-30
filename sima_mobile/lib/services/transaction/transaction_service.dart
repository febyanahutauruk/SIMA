import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/transaction/in_out_model.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/models/transaction/transaction_param_model.dart';
import 'package:sima/models/transaction/transaction_base_pagination_model.dart';

class TransactionService {
  Future<TransactionPaginationResponseModel> getPaginationTransaction(
      TransactionParamModel param) async {
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
    try {
      var url = Uri.https("apistrive.pertamina-ptk.com", "api/ItemInOut/DTMobile");

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(itemInOut.toJson()),
      );

      if (response.statusCode == 200) {
        print("Item added successfully");
      } else {
        throw Exception("Failed to add item: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error adding item: $e");
    }
  }

  Future<String> getFileUrl(int trxId) async {
    try {
      var url = Uri.https("apistrive.pertamina-ptk.com", "api/masterdata/FileReader/$trxId");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return jsonResponse['fileUrl'] ?? 'https://via.placeholder.com/100';
      } else {
        print("Failed to fetch file URL: ${response.statusCode} - ${response.body}");
        return 'https://via.placeholder.com/100';
      }
    } catch (e) {
      print("Error fetching file URL: $e");
      return 'https://via.placeholder.com/100';
    }
  }
}
