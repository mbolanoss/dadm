import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/services/db_service.dart';
import 'package:reto_8/utils/custom_theme.dart';
import 'package:reto_8/widgets/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = DBService();
  await dbService.database;

  runApp(
    MultiProvider(
      providers: [
        Provider<DBService>(
          create: (_) => dbService,
          lazy: false,
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
      title: 'Reto 8',
      theme: lightTheme,
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
