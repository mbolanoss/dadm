import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto10/screens/home_screen.dart';
import 'package:reto10/services/api_service.dart';
import 'package:reto10/utils/custom_theme.dart';

void main() async {
  final apiService = ApiService();

  final response = await apiService.getAllData();
  print(response.length);

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ApiService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const HomeScreen(),
    );
  }
}
