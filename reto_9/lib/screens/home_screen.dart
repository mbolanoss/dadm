import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';
import 'package:reto_9/services/markers_service.dart';

import '../models/custom_marker.dart';

class HomeScreen extends StatelessWidget {
  final MapController mapController = MapController();
  HomeScreen({super.key});

  List<Marker> buildMarkers(List<CustomMarker> customMarkers) {
    final markerList = <Marker>[];

    for (final customMarker in customMarkers) {
      final newMarker = Marker(
        point: LatLng(customMarker.latitude, customMarker.longitude),
        child: GestureDetector(
          child: Container(
            width: 15,
            height: 15,
            color: Colors.red,
          ),
        ),
      );

      markerList.add(newMarker);
    }

    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    final userCoords = context.read<Position>();
    final markersService = context.read<MarkersService>();

    final _markers = buildMarkers(markersService.customMarkers);

    return FlutterMap(
      mapController: mapController,
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
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
