import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/item/base_pagination_model.dart';
import 'package:sima/models/item/item_pagination_param_model.dart';

class ItemService {
  Future<ItemPaginationResponseModels> getPaginationItem(
      ItemPaginationParamModel param) async {
    try {
      var url = Uri.https("apistrive.pertamina-ptk.com", "api/Items/DTMobile");

      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(param.toJson())
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        var result = ItemPaginationResponseModels.fromJson(jsonResponse);
        return result;
      }

      return ItemPaginationResponseModels(data: [],
          offset: param.offset, isNext: false);
    } catch (e) {
      throw Exception("error: ${e.toString()}");
    }
  }

  Future<List<Category>> fetchCategoryList() async {
    final response = await http.get(Uri.parse('https://apistrive.pertamina-ptk.com/api/Category'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<Category>.from(data.map((item) => Category.fromJson(item)));
    } else {
      throw Exception('Failed to load category');
    }
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

