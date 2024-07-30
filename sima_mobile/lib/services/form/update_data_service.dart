import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sima/models/form/update_data_model.dart';

class UpdateDataService {
  Future<void> updateData(UpdateDataModel item) async {
    var uri = Uri.parse('https://apistrive.pertamina-ptk.com/api/Items/Update/${item.id}');
    print('Update URL: $uri');

    var request = http.MultipartRequest('PUT', uri);
    request.fields['id'] = item.id.toString();
    request.fields['name'] = item.name;
    request.fields['code'] = item.code;
    request.fields['Description'] = item.description ?? '';
    request.fields['CategoryId'] = item.category?.toString() ?? '0';
    request.fields['createdBy'] = item.createdBy;

    if (item.fileUploads != null) {
      request.files.add(await http.MultipartFile.fromPath('fileUpload', item.fileUploads!.path));
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
      Uri.parse('https://apistrive.pertamina-ptk.com/api/Items/Delete/$id'),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item: ${response.statusCode}, ${response.body}');
    }
  }
}
