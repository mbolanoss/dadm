import 'package:flutter/material.dart';
import 'package:reto_9/models/custom_marker.dart';

class MarkerSheet extends StatelessWidget {
  final CustomMarker customMarker;
  const MarkerSheet({
    super.key,
    required this.customMarker,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Text(customMarker.name),
        ],
      ),
    );
  }
}
