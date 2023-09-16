import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class DifficultyList extends StatelessWidget {
  const DifficultyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();
    final screenSize = MediaQuery.of(context).size;

    Difficulty currentDifficulty = ticTacToe.currentDifficulty;

    return Container(
      constraints: BoxConstraints(maxHeight: screenSize.height * 0.4),
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Dificultad',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Easy diff
            RadioListTile(
              title: const Text(
                'Fácil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              value: Difficulty.easy,
              groupValue: currentDifficulty,
              onChanged: (newDifficulty) {
                ticTacToe.changeDifficulty(newDifficulty!);
              },
            ),

            // Harder diff
            RadioListTile(
              title: const Text(
                'Díficil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              value: Difficulty.harder,
              groupValue: currentDifficulty,
              onChanged: (newDifficulty) {
                ticTacToe.changeDifficulty(newDifficulty!);
              },
            ),

            // Expert diff
            RadioListTile(
              title: const Text(
                'Experto',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              value: Difficulty.expert,
              groupValue: currentDifficulty,
              onChanged: (newDifficulty) {
                ticTacToe.changeDifficulty(newDifficulty!);
              },
            ),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
