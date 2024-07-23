import 'package:http/http.dart' as http;
import 'package:sima/models/form/item_form_model.dart';
import 'dart:convert';

class ItemFormService {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/api/Items/Add';

  Future<void> addItem(ItemFormModel item) async {
    final Map<String, dynamic> itemData = item.toJson();

    print('Sending data: ${jsonEncode(itemData)}');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(itemData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Item added successfully.');
      } else {
        print('Failed to add item: ${response.statusCode} ${response.body}');
        throw Exception('Failed to add item: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}
