import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/providers/company_provider.dart';
import 'package:reto_8/screens/handle_company.dart';
import 'package:reto_8/services/db_service.dart';
import 'package:reto_8/utils/custom_theme.dart';
import 'package:reto_8/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = DBService();
  await dbService.database;

  final companyProvider = CompanyProvider();
  companyProvider.companiesList = await dbService.getAllCompanies();
  companyProvider.dbService = dbService;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => companyProvider),
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/handleCompany': (context) => HandleCompany(),
      },
    );
  }
}
