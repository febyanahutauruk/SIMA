import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sima/models/form/update_data_model.dart';
import 'package:sima/services/form/update_data_service.dart';

class UpdateDataService {
  Future<void> updateData(UpdateDataModel item) async {
    var uri = Uri.parse('https://apistrive.pertamina-ptk.com/api/Items/Update');

    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = item.name;
    request.fields['code'] = item.code;
    request.fields['description'] = item.description;
    request.fields['category'] = item.category ?? '';
    request.fields['createdBy'] = item.createdBy;

    // if (item.fileUploads != null && item.fileUploads!.isNotEmpty) {
    //   final decodedImage = base64Decode(item.fileUploads!);
    //   request.files.add(http.MultipartFile.fromBytes(
    //     'fileUploads',
    //     decodedImage,
    //     filename: 'image.jpg', 
    //   ));
    // }

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to update item: ${response.statusCode}');
    }
  }
}
