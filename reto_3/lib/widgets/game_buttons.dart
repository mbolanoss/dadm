import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class GameButtons extends StatelessWidget {
  const GameButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Reset
        ElevatedButton(
          onPressed: () {
            ticTacToe.resetHistory();
            ticTacToe.resetGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 241, 197, 6),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'Reset',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // New game
        ElevatedButton(
          onPressed: () {
            ticTacToe.saveHistory();
            ticTacToe.resetGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 241, 197, 6),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'Juego nuevo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
