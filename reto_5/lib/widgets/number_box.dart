import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class NumberBox extends StatelessWidget {
  const NumberBox({
    super.key,
    required this.position,
  });

  final int position;
  static const BorderSide border =
      BorderSide(color: Color.fromARGB(255, 0, 155, 255), width: 4);

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();
    return GridTile(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ticTacToe.winnerPositions.contains(position)
                ? Colors.amber
                : Colors.transparent,
          ),
          onPressed: ticTacToe.boardState[position] == TicTacToe.emptySpot &&
                  ticTacToe.winner == 0
              ? () {
                  ticTacToe.makeTurn(position);
                }
              : null,
          child: ticTacToe.boardState[position] == 0
              ? const Text("")
              : ticTacToe.boardState[position] == 1
                  ? Image.asset("assets/x.png")
                  : Image.asset("assets/o.png"),

          // Text(
          //   ticTacToe.boardState[position] == 0
          //       ? ''
          //       : ticTacToe.boardState[position] == 1
          //           ? 'X'
          //           : 'O',
          //   style: TextStyle(
          //     fontSize: 40,
          //     color: ticTacToe.winnerPositions.contains(position)
          //         ? Colors.black
          //         : Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ),
      ),
    );
  }

  BoxBorder getBorder(int position) {
    switch (position) {
      case 0:
        return const BorderDirectional(bottom: border, end: border);
      case 1:
        return const BorderDirectional(bottom: border, end: border);
      case 2:
        return const BorderDirectional(bottom: border);
      case 3:
        return const BorderDirectional(bottom: border, end: border);
      case 4:
        return const BorderDirectional(bottom: border, end: border);
      case 5:
        return const BorderDirectional(bottom: border);
      case 6:
        return const BorderDirectional(end: border);
      case 7:
        return const BorderDirectional(end: border);
      case 8:
        return const BorderDirectional();
      default:
        return const BorderDirectional();
    }
  }
}
