import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final device = DeviceInfoPlugin();

                  final androidInfo = await device.androidInfo;
                  print(androidInfo.id);
                },
                child: Text('sdasd'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
