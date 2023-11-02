import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCoords = context.read<Position>();

    return FlutterMap(
      options: MapOptions(
        initialZoom: 9.2,
        initialCenter: LatLng(userCoords.latitude, userCoords.longitude),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/mbolanoss/clohfm14g001401pee8zi3xaq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWJvbGFub3NzIiwiYSI6ImNsb2c3bXFuMzBxbDYyam8zbGk4cmE1dGQifQ.hI6q-CDuhpk54sNiVjc2Iw',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );
  }
}
