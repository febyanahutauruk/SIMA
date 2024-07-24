import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sima/models/form/item_form_model.dart';
import 'dart:io';

class ItemFormService {
  final String apiUrl = 'https://apistrive.pertamina-ptk.com/api/Items/Add';

  Future<void> addItem(ItemFormModel item) async {
    validateItem(item);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'Accept': 'application/json',
      });

      item.toJson().forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (item.fileUploads != null && item.fileUploads!.isNotEmpty) {
        for (File file in item.fileUploads!) {
          String? mimeType = lookupMimeType(file.path);
          if (mimeType != null) {
            var multipartFile = await http.MultipartFile.fromPath(
              'fileUploads',
              file.path,
              contentType: MediaType.parse(mimeType),
            );
            request.files.add(multipartFile);
          }
        }
      }

      print('Sending data: ${request.fields}'); // Log data yang dikirim

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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

  void validateItem(ItemFormModel item) {
    if (item.name == null || item.name.isEmpty) {
      throw Exception('Name is required');
    }
  }
}
