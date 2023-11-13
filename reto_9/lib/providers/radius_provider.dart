import 'package:flutter/material.dart';

class RadiusProvider with ChangeNotifier {
  int radius;

  RadiusProvider({required this.radius});

  void changeRadius(int newRadius) {
    radius = newRadius;
    notifyListeners();
  }
}
