import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmfusion_app/dto/uts.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';

class DataServices {
  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.endUTS));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Sorry Failed to load Datas');
    }
  }

  static Future<void> deleteDatas(int id) async {
    final url = Uri.parse('${Endpoints.endUTS}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }
}