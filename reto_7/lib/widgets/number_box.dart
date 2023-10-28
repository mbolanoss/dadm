import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tic_tac_toe.dart';

class NumberBox extends StatelessWidget {
  const NumberBox({
    super.key,
    required this.position,
  });

  final int position;
  static const BorderSide border = BorderSide(color: Colors.grey, width: 4);

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();
    return GridTile(
      child: Container(
        decoration: BoxDecoration(border: getBorder(position)),
        padding: const EdgeInsets.all(15),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ticTacToe.winnerPositions.contains(position)
                ? Colors.amber
                : Colors.transparent,
          ),
          onPressed: ticTacToe.boardState[position] == TicTacToe.emptySpot &&
                  ticTacToe.winner == 0
              ? () async {
                  final player = AudioPlayer();
                  player.play(AssetSource("player1.mp3"));

                  ticTacToe.makeTurn(position);
                }
              : null,
          child: ticTacToe.boardState[position] == 0
              ? const Text("")
              : ticTacToe.boardState[position] == 1
                  ? const Text("1")
                  : const Text("2"),
          // ticTacToe.boardState[position] == 0
          //     ? const Text("")
          //     : ticTacToe.boardState[position] == 1
          //         ? Image.asset("assets/x.png")
          //         : Image.asset("assets/o.png"),
        ),
      ),
    );
  }

  BoxBorder getBorder(int position) {
    switch (position) {
      case 0:
        return const BorderDirectional(
            bottom: border, end: border, start: border, top: border);
      case 1:
        return const BorderDirectional(
            bottom: border, end: border, top: border);
      case 2:
        return const BorderDirectional(
            bottom: border, top: border, end: border);
      case 3:
        return const BorderDirectional(
            bottom: border, end: border, start: border);
      case 4:
        return const BorderDirectional(bottom: border, end: border);
      case 5:
        return const BorderDirectional(bottom: border, end: border);
      case 6:
        return const BorderDirectional(
            end: border, start: border, bottom: border);
      case 7:
        return const BorderDirectional(end: border, bottom: border);
      case 8:
        return const BorderDirectional(end: border, bottom: border);
      default:
        return const BorderDirectional();
    }
  }
}
