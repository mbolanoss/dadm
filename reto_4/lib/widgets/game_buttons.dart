import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class GameButtons extends StatelessWidget {
  const GameButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NewGameButton(),
        DifficultyButton(),
        CloseButton(),
      ],
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return ElevatedButton(
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
    );
  }
}

class DifficultyButton extends StatelessWidget {
  const DifficultyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: DifficultyList(),
              );
            });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 241, 197, 6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      child: const Icon(
        Icons.settings,
        color: Colors.black,
      ),
    );
  }
}

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

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        SystemNavigator.pop();
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
        'Salir',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
