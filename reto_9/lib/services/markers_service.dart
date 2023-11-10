import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/custom_marker.dart';

class MarkersService {
  // https://datosabiertos.bogota.gov.co/dataset/567c12a9-76d5-41ac-8032-49e8351ab0ae/resource/c0dedd38-da12-49ae-9361-f59663b4dd54/download/itur.geojson

  final String domain = "datosabiertos.bogota.gov.co";
  final String path =
      "dataset/567c12a9-76d5-41ac-8032-49e8351ab0ae/resource/c0dedd38-da12-49ae-9361-f59663b4dd54/download/itur.geojson";

  final List<CustomMarker> customMarkers = [];

  loadCustomMarkers() async {
    final url = Uri.https(domain, path);
    final response = await http.get(url);

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> places = data['features'];

    for (Map<String, dynamic> place in places) {
      final newMarker = CustomMarker.fromJson(place['properties']);
      customMarkers.add(newMarker);
    }
  }
}
