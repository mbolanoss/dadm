import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/screens/game_screen.dart';
import 'package:reto_3/screens/home_screen.dart';
import 'package:reto_3/services/tic_tac_toe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final deviceInfo = await DeviceInfoPlugin().androidInfo;
  final deviceId = deviceInfo.id;

  final ticTacToe = TicTacToe();
  ticTacToe.deviceId = deviceId;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ticTacToe,
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.signikaTextTheme(),
      ),
      routes: {
        '/': (_) => HomeScreen(),
        '/game': (_) => const GameScreen(),
      },
    );
  }
}
