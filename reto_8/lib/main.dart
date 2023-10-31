import 'package:flutter/material.dart';
import 'package:reto_8/utils/custom_theme.dart';
import 'package:reto_8/widgets/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reto 8',
      theme: lightTheme,
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
