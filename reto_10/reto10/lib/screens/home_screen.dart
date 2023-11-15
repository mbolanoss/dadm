import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'HOME SCREEN',
              style: textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}
