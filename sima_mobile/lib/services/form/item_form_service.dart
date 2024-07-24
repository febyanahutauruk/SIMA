  import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
  import 'package:sima/models/form/item_form_model.dart';
  import 'dart:convert';

  class ItemFormService {
    final String apiUrl = 'https://apistrive.pertamina-ptk.com/api/Items/Add';

    Future<void> addItem(ItemFormModel item,) async {
      final Map<String, dynamic> itemData = item.toJson();
        final request = http.MultipartRequest('POST', Uri.parse(apiUrl),);
        request.fields ['Code'] = item.code;
        request.fields ['Name'] = item.name;
        request.fields ['Description'] = item.description ?? '';
        request.fields ['CategoryId'] = item.category.toString();
        request.fields ['Username'] = item.createdBy;

        
        if (item.fileUploads == null){
          print('gambar kosong');
        }
        // File.fromRawPath(item.fileUploads!.first);
        var tempImage = item.fileUploads.toString();       
        request.files.add(await http.MultipartFile('FileImage', item.fileUploads!.readAsBytes().asStream(), item.fileUploads!.lengthSync(),));
        print('Sending data: ${jsonEncode(itemData)}');
      var response = await request.send();
            print(await response.stream.bytesToString());
            if (response.statusCode == 200) {
              print("success");
            } else {
              print("gagal");
            }       
  }
}