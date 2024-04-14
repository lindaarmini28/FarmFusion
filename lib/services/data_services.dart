import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/dto/news.dart';

class DataServices {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  static Future<void> createNews(String title, String body) async {
    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create news');
    }
  }

  static Future<void> updateNews(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('${Endpoints.news}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      print('News updated successfully');
    } else {
      throw Exception('Failed to update news');
    }
  }

  static Future<void> deleteNews(int id) async {
    final response = await http.delete(Uri.parse('${Endpoints.news}/$id'));

    if (response.statusCode == 200) {
      print('News deleted successfully');
    } else {
      throw Exception('Failed to delete news');
    }
  }
}
