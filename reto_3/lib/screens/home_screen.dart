import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  HomeScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Title
            const Text(
              'TicTacToe',
              style: TextStyle(
                fontSize: 38,
              ),
            ),

            // Board
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: ticTacToe.boardState.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return ElevatedButton(
                      onPressed:
                          ticTacToe.boardState[i] == TicTacToe.emptySpot &&
                                  ticTacToe.winner == 0
                              ? () {
                                  ticTacToe.makeTurn(i);
                                }
                              : null,
                      child: Text('${ticTacToe.boardState[i]}'));
                }),

            // Reset btn
            ElevatedButton(
                onPressed: () => ticTacToe.resetGame(),
                child: const Text('Reset')),

            Text(
              '${ticTacToe.winner}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
