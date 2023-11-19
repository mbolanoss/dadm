import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reto10/models/db_entry.dart';

// const String baseUrl = "https://www.datos.gov.co/resource/4vk3-rzfy.json";

const String domain = "datos.gov.co";
const String path = "resource/4vk3-rzfy.json";

enum FilterType {
  technology,
  segment,
  supplier,
  none,
}

class ApiService with ChangeNotifier {
  List<DBEntry> data = [];
  Map<Supplier, int> amounts = {};

  FilterType filter = FilterType.technology;

  void changeFilter(FilterType newFilter) {
    filter = newFilter;
    notifyListeners();
  }

  void countAmounts() {
    for (final supplierValue in Supplier.values) {
      amounts[supplierValue] =
          data.where((e) => e.provider == supplierValue).length;
    }
  }

  Future<void> fetchAllData() async {
    final url = Uri.https(domain, path);
    final response = await http.get(url);

    final List<dynamic> rawData = jsonDecode(response.body);

    for (Map<String, dynamic> item in rawData) {
      final newEntry = DBEntry.fromJson(item);
      data.add(newEntry);
    }

    countAmounts();
  }

  Future<void> fetchByTechnology(Technology tech) async {
    data.clear();

    final url = Uri.https(domain, path, {
      'tecnolog_a': technologyValues.reverse[tech],
    });
    final response = await http.get(url);

    final List<dynamic> rawData = jsonDecode(response.body);

    for (Map<String, dynamic> item in rawData) {
      final newEntry = DBEntry.fromJson(item);
      data.add(newEntry);
    }

    countAmounts();

    notifyListeners();
  }

  Future<void> fetchBySegment(Segment segment) async {
    data.clear();

    final url = Uri.https(domain, path, {
      'segmento': segmentValues.reverse[segment],
    });
    final response = await http.get(url);

    final List<dynamic> rawData = jsonDecode(response.body);

    for (Map<String, dynamic> item in rawData) {
      final newEntry = DBEntry.fromJson(item);
      data.add(newEntry);
    }

    countAmounts();

    notifyListeners();
  }
}
