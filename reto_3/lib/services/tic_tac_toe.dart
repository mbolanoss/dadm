import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe with ChangeNotifier {
  final boardState = List.filled(9, emptySpot);

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;

  int currentTurn = player1;
  bool isAgainstCPU = true;

  TicTacToe() {}

  void resetGame() {
    for (int i = 0; i < boardState.length; i++) {
      boardState[i] = emptySpot;
    }

    currentTurn = player1;
    notifyListeners();
  }

  // true if location is available, false otherwise
  void setMove(int location) {
    if (boardState.any((position) => position == emptySpot)) {
      if (boardState[location] == emptySpot) {
        boardState[location] = currentTurn;

        // next turn
        currentTurn = currentTurn == player1 ? player2 : player1;

        notifyListeners();
      }
    }
  }

  int getComputerMove() {
    Random random = Random();
    int location;

    while (true) {
      location = random.nextInt(9);

      if (boardState[location] == emptySpot) {
        return location;
      }
    }
  }

  int checkWinner() {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (boardState[i] == player1 &&
          boardState[i + 1] == player1 &&
          boardState[i + 2] == player1) return player1;
      if (boardState[i] == player2 &&
          boardState[i + 1] == player2 &&
          boardState[i + 2] == player2) return player2;
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (boardState[i] == player1 &&
          boardState[i + 3] == player1 &&
          boardState[i + 6] == player1) return player1;
      if (boardState[i] == player2 &&
          boardState[i + 3] == player2 &&
          boardState[i + 6] == player2) return player2;
    }

    // Check for diagonal wins
    if ((boardState[0] == player1 &&
            boardState[4] == player1 &&
            boardState[8] == player1) ||
        (boardState[2] == player1 &&
            boardState[4] == player1 &&
            boardState[6] == player1)) return player1;
    if ((boardState[0] == player2 &&
            boardState[4] == player2 &&
            boardState[8] == player2) ||
        (boardState[2] == player2 &&
            boardState[4] == player2 &&
            boardState[6] == player2)) return player2;

    // Check for tie
    for (int i = 0; i < 9; i++) {
      // If we find a number, then no one has won yet
      if (boardState[i] == emptySpot) return 0;
    }

    // If we make it through the previous loop, all places are taken, so it's a tie
    return 3;
  }
}
