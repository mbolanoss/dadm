import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';
import 'package:reto_9/services/markers_service.dart';
import 'package:reto_9/utils/custom_theme.dart';
import 'package:reto_9/widgets/marker_sheet.dart';

import '../models/custom_marker.dart';

class HomeScreen extends StatelessWidget {
  final MapController mapController = MapController();
  HomeScreen({super.key});

  List<Marker> buildMarkers(
      List<CustomMarker> customMarkers, BuildContext context) {
    final markerList = <Marker>[];

    for (final customMarker in customMarkers) {
      final newMarker = Marker(
        point: LatLng(customMarker.latitude, customMarker.longitude),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return MarkerSheet(customMarker: customMarker);
              },
            );
          },
          child: const Icon(
            Icons.location_on_sharp,
            color: Colors.red,
            size: 40,
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

    final markers = buildMarkers(markersService.customMarkers, context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialZoom: 15,
                initialCenter:
                    LatLng(userCoords.latitude, userCoords.longitude),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mbolanoss/clohfm14g001401pee8zi3xaq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWJvbGFub3NzIiwiYSI6ImNsb2c3bXFuMzBxbDYyam8zbGk4cmE1dGQifQ.hI6q-CDuhpk54sNiVjc2Iw',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: markers,
                  rotate: true,
                ),
              ],
            ),
            PositionForm(
              mapController: mapController,
            ),
          ],
        ),
      ),
    );
  }
}

class PositionForm extends StatelessWidget {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final MapController mapController;

  PositionForm({
    super.key,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final userCoords = context.read<Position>();

    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: const BoxDecoration(
        color: lavender,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: latitudeController,
            decoration: const InputDecoration(hintText: 'Latitud'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Longitud'),
            controller: longitudeController,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  final latitude = double.parse(latitudeController.text);
                  final longitude = double.parse(longitudeController.text);

                  mapController.move(LatLng(latitude, longitude), 15);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Ubicar',
                    style: textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  mapController.move(
                      LatLng(userCoords.latitude, userCoords.longitude), 15);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.loop,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
