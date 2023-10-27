import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:reto_3/services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final device = DeviceInfoPlugin();

                  final androidInfo = await device.androidInfo;
                  print(androidInfo.id);
                },
                child: Text('device id'),
              ),
              ElevatedButton(
                onPressed: () async {
                  firestoreService.getAllGames();
                },
                child: Text('games info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
