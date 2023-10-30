import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/firestore_service.dart';

import '../services/tic_tac_toe.dart';

class BottomGameButtons extends StatelessWidget {
  const BottomGameButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      children: [
        const CloseButton(),
        NewGameButton(),
      ],
    );
  }
}

class NewGameButton extends StatelessWidget {
  final firestoreService = FirestoreService();
  NewGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return ElevatedButton(
      onPressed: () async {
        await firestoreService.updateScore(
            player1Wins: ticTacToe.player1Wins,
            player2Wins: ticTacToe.player2Wins,
            ties: ticTacToe.ties,
            turn: ticTacToe.currentTurn,
            gameId: ticTacToe.gameId!);

        await firestoreService.resetGame(
            ticTacToe.player1Id!, ticTacToe.gameId!);

        ticTacToe.updateScore();
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

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pushReplacementNamed('/');
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
