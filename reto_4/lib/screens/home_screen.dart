import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

import '../widgets/bottom_app_buttons.dart';
import '../widgets/game_buttons.dart';
import '../widgets/number_box.dart';
import '../widgets/status_text.dart';

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
      backgroundColor: const Color.fromARGB(255, 40, 60, 79),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
            screenSize.width * 0.13,
            screenSize.height * 0.02,
            screenSize.width * 0.13,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Title
              const Title(),

              SizedBox(height: screenSize.height * 0.04),

              // Board
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: ticTacToe.boardState.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return NumberBox(position: i);
                  }),

              SizedBox(height: screenSize.height * 0.01),

              // Status text
              const StatusText(),

              SizedBox(height: screenSize.height * 0.01),
              const Score(),
            ],
          ),
        )),
      ),
      bottomNavigationBar: const BottomAppButtons(),
    );
  }
}

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

        // Reset score button
        ElevatedButton(
          onPressed: () {
            ticTacToe.resetHistory();
            // ticTacToe.resetGame();
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: const Color.fromARGB(255, 241, 197, 6),
          ),
          child: const Icon(
            Icons.replay,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'TicTacToe',
          style: TextStyle(
            fontSize: 38,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: screenSize.width * 0.4,
          height: 4,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        )
      ],
    );
  }
}
