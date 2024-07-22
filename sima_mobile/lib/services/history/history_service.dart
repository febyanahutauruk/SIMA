import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sima/models/history/base_pagination_model.dart';
import 'package:sima/models/history/history_pagination_param_model.dart';

class HistoryService{

  Future<HistoryPaginationResponseModels> getPaginationItem(
      HistoryPaginationParamModel param) async{

    try{
      var url = Uri.https("apistrive.pertamina-ptk.com", "api/ItemInOut/DTMobile");

      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(param.toJson())

      );
      print (response.statusCode);
      print (response.body);

      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        var result = HistoryPaginationResponseModels.fromJson(jsonResponse);
        print("cek result : $result");
        print("cek result2 : $result.data");
        return result;

      }

      return HistoryPaginationResponseModels(data: [],
          offset: param.offset, isNext: false);
    } catch(e) {
      throw Exception("error: ${e.toString()}");
    }
  }
}
