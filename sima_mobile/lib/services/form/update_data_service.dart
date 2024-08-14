import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/form/update_data_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UpdateDataService {
  Future<void> updateData(UpdateDataModel item) async {
    if (item.id == null) {
      throw Exception('Item ID is required for updating.');
    }

    final url = Uri.parse('https://apistrive.pertamina-ptk.com/api/Items/Update/${item.id}');
    final request = http.MultipartRequest(
      'PUT',
      url,
    );


    request.fields['Code'] = item.code;
    request.fields['Name'] = item.name;
    request.fields['Description'] = item.description ?? '';
    request.fields['CategoryId'] = item.category?.toString() ?? '0';
    request.fields['Id'] = '';
    request.fields['Username'] = item.createdBy;


    if (item.fileUploads != null) {
      var filePath = item.fileUploads!.path;
      var fileName = filePath.split('/').last;
      var mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

      request.files.add(
        await http.MultipartFile.fromPath(
          'FileImage',
          filePath,
          contentType: MediaType.parse(mimeType),
          filename: fileName,
        ),
      );
    } else {
      print('No image to upload.');
    }


    print('Update data: ${jsonEncode(item.toJson())}');
    print('Request URL: ${url}');
    print('Request Fields: ${request.fields}');
    if (item.fileUploads != null) {
      print('Request File: ${item.fileUploads!.path}');
    }

    var response = await request.send();
    var responseBody = await http.Response.fromStream(response);

    print('Response status: ${response.statusCode}');
    print('Response body: ${responseBody.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update item: ${response.statusCode}, ${responseBody.body}');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('https://apistrive.pertamina-ptk.com/api/Items/Delete/$id?deleteby=aufar'),
    );

    print('id: $id');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item: ${response.statusCode}, ${response.body}');
    }
  }
}
