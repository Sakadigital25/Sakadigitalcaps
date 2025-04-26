import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionService {
  static Future<List<String>> getProvinces() async {
    final url = Uri.parse('https://ibnux.github.io/data-indonesia/provinsi.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((prov) => prov['nama'].toString()).toList();
    } else {
      throw Exception("Failed to load provinces");
    }
  }

  static Future<List<String>> getCities(String provinceId) async {
    final url = Uri.parse('https://ibnux.github.io/data-indonesia/kota/$provinceId.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((city) => city['nama'].toString()).toList();
    } else {
      throw Exception("Failed to load cities");
    }
  }

  // Untuk mapping nama provinsi ke ID
  static Future<Map<String, String>> getProvinceMap() async {
    final url = Uri.parse('https://ibnux.github.io/data-indonesia/provinsi.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return {
        for (var item in data) item['nama']: item['id'].toString(),
      };
    } else {
      throw Exception("Failed to load province map");
    }
  }
}
