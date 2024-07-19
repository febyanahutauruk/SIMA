import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sima/models/item/base_pagination_model.dart';
import 'package:sima/models/item/item_pagination_param_model.dart';
import 'package:sima/models/item/item_pagination_model.dart';

class ItemService{

  Future<ItemPaginationResponseModels> getPaginationItem(
    ItemPaginationParamModel param) async{

  try{
    var url = Uri.https("apistrive.pertamina-ptk.com", "api/Items/DTMobile");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(param.toJson())
    );

    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ItemPaginationResponseModels.fromJson(jsonResponse);
    }

    return ItemPaginationResponseModels(data: [], 
      offset: param.offset, isNext: false);
} catch(e) { 
  throw Exception("error: ${e.toString()}");
  }
 }
}
