import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmfusion_app/dto/datas.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';

class DataServices {
   static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas']as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load Datas');
      }
    }

    static Future<List<Datas>> deleteDatas(String id) async {
    await http.delete(Uri.parse('${Endpoints.datas}/$id'),
        headers: {'Content-type': 'application/json'});
    return fetchDatas();
  }
  static Future<void> updateDatas(String id, String title, String body) async {
    Map<String, String> data = {"id": id, "title": title, "body": body};
    String jsonData = jsonEncode(data);
    await http.put(Uri.parse('${Endpoints.datas}/$id'),
        body: jsonData, headers: {'Content-type': 'application/json'});
  }
}