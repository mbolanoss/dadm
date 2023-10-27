import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class StatusText extends StatelessWidget {
  const StatusText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: ticTacToe.winner != 0
          ? const BoxDecoration(
              color: Color.fromARGB(255, 0, 155, 255),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            )
          : const BoxDecoration(),
      child: Text(
        getText(ticTacToe.currentTurn, ticTacToe.winner),
        style: TextStyle(
          fontSize: 22,
          color: ticTacToe.winner == 0 ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  String getText(int currentTurn, int winner) {
    switch (winner) {
      case 0:
        return currentTurn == TicTacToe.player1
            ? 'Turno de: Jugador 1'
            : 'Turno de: Jugador 2';
      case 1:
        return 'Gana Jugador 1 🎉';
      case 2:
        return 'Gana Jugador 2 🎉';

      case 3:
        return 'Empate 😒';

      default:
        return '';
    }
  }
}
