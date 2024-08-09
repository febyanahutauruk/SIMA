import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _baseUrl = 'https://apistrive.pertamina-ptk.com/api/News';

  Future<List<String>> fetchNewsImages() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((news) {
        final fileId = news['id'];
        return 'https://apistrive.pertamina-ptk.com/api/News/$fileId/Image?isStream=true';
      }).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
