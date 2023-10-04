import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';
import 'difficulty_list.dart';

class BottomGameButtons extends StatelessWidget {
  const BottomGameButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      children: [
        DifficultyButton(),
        CloseButton(),
        NewGameButton(),
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
