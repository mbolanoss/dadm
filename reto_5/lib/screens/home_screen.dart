import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

import '../widgets/bottom_app_buttons.dart';
import '../widgets/number_box.dart';
import '../widgets/score.dart';
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
            0,
            screenSize.width * 0.13,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Title
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.04,
                ),
                child: const Title(),
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
                    return NumberBox(position: i);
                  }),

              // Status text
              Container(
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.03,
                  bottom: screenSize.height * 0.01,
                ),
                child: const StatusText(),
              ),

              // Score
              Container(
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.01,
                  bottom: screenSize.height * 0.01,
                ),
                child: const Score(),
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
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: const BottomAppButtons(),
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
