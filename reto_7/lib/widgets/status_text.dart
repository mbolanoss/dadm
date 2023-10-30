import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/firestore_service.dart';

import '../services/tic_tac_toe.dart';

class StatusText extends StatelessWidget {
  final firestoreService = FirestoreService();
  StatusText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: firestoreService.getGameInfoStream(ticTacToe.gameId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
              getText(ticTacToe),
              style: TextStyle(
                fontSize: 22,
                color: ticTacToe.winner == 0 ? Colors.white : Colors.black,
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        }
      },
    );

    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    //   decoration: ticTacToe.winner != 0
    //       ? const BoxDecoration(
    //           color: Color.fromARGB(255, 0, 155, 255),
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(20),
    //           ),
    //         )
    //       : const BoxDecoration(),
    //   child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //     stream: firestoreService.getGameInfoStream(ticTacToe.gameId!),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return Text(
    //           getText(ticTacToe),
    //           style: TextStyle(
    //             fontSize: 22,
    //             color: ticTacToe.winner == 0 ? Colors.white : Colors.black,
    //           ),
    //         );
    //       } else {
    //         return const CircularProgressIndicator(
    //           color: Colors.blue,
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  String getText(TicTacToe ticTacToe) {
    String currentTurn = ticTacToe.currentTurn;
    String text = '';

    if (currentTurn == ticTacToe.player1Id) {
      text = 'Turno de: Jugador 1';
    } else if (currentTurn == ticTacToe.player2Id) {
      text = 'Turno de: Jugador 2';
    } else if (currentTurn == 'win1') {
      text = 'Gana Jugador 1 🎉';
    } else if (currentTurn == 'win2') {
      text = 'Gana Jugador 2 🎉';
    } else if (currentTurn == 'tie') {
      text = 'Empate 😒';
    }
    return text;
  }
}
