import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/firestore_service.dart';
import 'package:reto_3/services/tic_tac_toe.dart';
import 'package:reto_3/widgets/bottom_game_buttons.dart';

import '../widgets/number_box.dart';
import '../widgets/score.dart';
import '../widgets/status_text.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final ticTacToe = context.watch<TicTacToe>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 60, 79),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (_, orientation) {
            //Orientacion vertical
            if (orientation == Orientation.portrait) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenSize.width * 0.13,
                    0,
                    screenSize.width * 0.13,
                    0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Board
                      SizedBox(
                        height: 300,
                        child: Boxes(),
                      ),

                      // Status text
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.01,
                        ),
                        child: StatusText(),
                      ),

                      // Score
                      Container(
                        margin: EdgeInsets.only(
                          top: screenSize.height * 0.01,
                          bottom: screenSize.height * 0.03,
                        ),
                        child: const Score(),
                      ),

                      const BottomGameButtons()
                    ],
                  ),
                ),
              );
            }
            // Orientacion horizontal
            else if (orientation == Orientation.landscape) {
              return Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  // Board
                  Expanded(
                    child: Boxes(),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Status text
                        Container(
                          margin: EdgeInsets.only(
                            bottom: screenSize.height * 0.02,
                          ),
                          child: StatusText(),
                        ),
                        // Score
                        Container(
                          margin: EdgeInsets.only(
                            top: screenSize.height * 0.02,
                          ),
                          child: const Score(),
                        ),

                        Container(
                          margin: const EdgeInsets.only(
                            top: 40,
                          ),
                          child: const BottomGameButtons(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}

class Boxes extends StatelessWidget {
  final firestoreService = FirestoreService();

  Boxes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.read<TicTacToe>();
    // print('TAMAÑO ${streamSnapshot.data!}');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: firestoreService.getGameInfoStream(ticTacToe.gameId!),
      builder: (context, gameStatusSnapshot) {
        if (gameStatusSnapshot.hasData) {
          final gameStatus =
              firestoreService.getGameStatus(gameStatusSnapshot.data!);
          ticTacToe.updateGameStatus(gameStatus);

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestoreService.getGameHistoryStream(ticTacToe.gameId!),
            builder: (_, historySnapshot) {
              if (historySnapshot.hasData) {
                final movesHistory =
                    firestoreService.getMovesListFromDoc(historySnapshot.data!);
                ticTacToe.updateBoardState(movesHistory);

                return GridView.builder(
                  // shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: ticTacToe.boardState.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return NumberBox(position: i);
                  },
                );
              }

              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 241, 197, 6),
              );
            },
          );
        } else {
          return const CircularProgressIndicator(
            color: Color.fromARGB(255, 241, 197, 6),
          );
        }
      },
    );
  }
}
