import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sima/models/map/map_model.dart';
import 'package:sima/models/transaction/add_transaction_list_model.dart';

class AddTransactionItemFormService {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/WarehouseItem/add';

  // Future<void> addItem(AddTransactionItemModel item) async {
  //   final Map<String, dynamic> itemData = item.toJson();
  //   final request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(apiUrl),
  //   );
  //   request.fields['warehouseId'] = item.warehouseId.toString();
  //   request.fields['itemId'] = item.itemId.toString();
  //   request.fields['aktor'] = item.aktor;
  //   request.fields['qty'] = item.qty.toString();
  //   request.fields['minQty'] = item.minQty.toString();


  //   print('Sending data: ${jsonEncode(itemData)}');
  //   var response = await request.send();
  //   print(await response.stream.bytesToString());
  //   if (response.statusCode == 200) {
  //     print("success");
  //   } else {
  //     print("gagal");
  //   }
  // }
  Future<void> addItem(AddTransactionItemModel item) async {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/WarehouseItem/add';
  final Map<String, dynamic> itemData = item.toJson();

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  final body = jsonEncode(itemData);

  print('Sending data: $body');

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    print("Success");
  } else {
    print("Failed: ${response.statusCode} ${response.body}");
  }
}
Future<List<Warehouses>> fetchWarehouseList() async {
    final response = await http.get(Uri.parse('https://apistrive.pertamina-ptk.com/Warehouses'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<Warehouses>.from(data.map((item) => Warehouses.fromJson(item)));
    } else {
      throw Exception('Failed to load items');
    }
  }

Future<List<Items>> fetchItemsList() async {
    final response = await http.get(Uri.parse('https://apistrive.pertamina-ptk.com/api/Items'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<Items>.from(data.map((item) => Items.fromJson(item)));
    } else {
      throw Exception('Failed to load items');
    }
  }
}


class Items {
  final int id;
  final String name;

  Items({required this.id, required this.name});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
    );
  }
}


class Warehouses {
  final int id;
  final String name;

  Warehouses({required this.id, required this.name});

  factory Warehouses.fromJson(Map<String, dynamic> json) {
    return Warehouses(
      id: json['id'],
      name: json['name'],
    );
  }
}
