import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';
import '../services/tic_tac_toe.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        // Score text
        Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.01,
            horizontal: screenSize.width * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 4,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 25,
            children: [
              Text(
                'Jugador 1: ${ticTacToe.player1Wins}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                'Jugador 2: ${ticTacToe.player2Wins}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                'Empate: ${ticTacToe.ties}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        ResetScoreButton(),
      ],
    );
  }
}

class ResetScoreButton extends StatelessWidget {
  final firestoreService = FirestoreService();

  ResetScoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return ElevatedButton(
      onPressed: () async {
        await firestoreService.resetScore(ticTacToe.gameId!);

        ticTacToe.resetScore();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 241, 197, 6),
      ),
      child: const Icon(
        Icons.replay,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
