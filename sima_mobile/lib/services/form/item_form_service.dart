import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sima/models/form/item_form_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart'; 

class ItemFormService {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/api/Items/Add';

  Future<void> addItem(ItemFormModel item) async {
    final Map<String, dynamic> itemData = item.toJson();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );
    request.fields['Code'] = item.code;
    request.fields['Name'] = item.name;
    request.fields['Description'] = item.description ?? '';
    request.fields['CategoryId'] = item.category.toString();
    request.fields['Username'] = item.createdBy;

    if (item.fileUploads == null) {
      print('gambar kosong');
    } else {
      var filePath = item.fileUploads!.path;
      var fileName = item.fileUploads!.path.split('/').last;
      var mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

      request.files.add(
        await http.MultipartFile.fromPath(
          'FileImage',
          filePath,
          contentType: MediaType.parse(mimeType),
          filename: fileName,
        ),
      );
    }

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