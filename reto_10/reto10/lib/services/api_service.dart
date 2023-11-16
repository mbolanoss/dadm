import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reto10/models/db_entry.dart';

// const String baseUrl = "https://www.datos.gov.co/resource/4vk3-rzfy.json";

const String domain = "datos.gov.co";
const String path = "resource/4vk3-rzfy.json";

class ApiService {
  Future<List<Welcome>> test() async {
    final url = Uri.https(domain, path);
    final response = await http.get(url);

    final List<dynamic> rawData = jsonDecode(response.body);

    final list = <Welcome>[];

    for (Map<String, dynamic> item in rawData) {
      final newEntry = Welcome.fromJson(item);
      list.add(newEntry);
    }

    return list;
  }
}
