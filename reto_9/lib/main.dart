import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:reto_9/services/geolocator_service.dart';
import 'package:reto_9/services/markers_service.dart';
import 'package:reto_9/utils/custom_theme.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final geoLocator = GeoLocatorService();
  final userCoords = await geoLocator.getCurrentPosition();

  final markersService = MarkersService();
  await markersService.loadCustomMarkers();

  runApp(
    MultiProvider(
      providers: [
        Provider<Position>(
          create: (_) => userCoords,
        ),
        Provider<MarkersService>(
          create: (_) => markersService,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
      },
    );
  }
}
