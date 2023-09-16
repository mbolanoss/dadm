import 'package:flutter/material.dart';
import 'package:reto_3/widgets/bottom_game_buttons.dart';

class BottomAppButtons extends StatelessWidget {
  const BottomAppButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BottomAppBar(
      height: screenSize.height * 0.09,
      color: Colors.black38,
      child: const BottomGameButtons(),
    );
  }
}
