import 'package:flutter/material.dart';
import 'package:reto_9/models/custom_marker.dart';
import 'package:reto_9/utils/custom_theme.dart';

class MarkerSheet extends StatelessWidget {
  final CustomMarker customMarker;
  const MarkerSheet({
    super.key,
    required this.customMarker,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 400,
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(15)),
                child: Text(
                  customMarker.name,
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              PlaceItem(
                info: customMarker.address,
                icon: Icons.signpost,
              ),
              const ItemDivider(),
              PlaceItem(
                info: customMarker.ownerName,
                icon: Icons.person,
              ),
              const ItemDivider(),
              PlaceItem(
                info: customMarker.email,
                icon: Icons.email,
              ),
              const ItemDivider(),
              PlaceItem(
                info: customMarker.phoneNumber.toString(),
                icon: Icons.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDivider extends StatelessWidget {
  const ItemDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 5,
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class PlaceItem extends StatelessWidget {
  final String info;
  final IconData icon;
  const PlaceItem({
    super.key,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 50,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            info,
            style: textTheme.displaySmall,
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
