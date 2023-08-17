import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe with ChangeNotifier {
  final boardState = List.filled(9, emptySpot);

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;

  int currentTurn = player1;
  bool isAgainstCPU = true;
  int winner = 0;

  int player1Wins = 0;
  int player2Wins = 0;
  int ties = 0;

  void saveHistory() {
    player1Wins = winner == 1 ? player1Wins + 1 : player1Wins;
    player2Wins = winner == 2 ? player2Wins + 1 : player2Wins;
    ties = winner == 3 ? ties + 1 : ties;

    notifyListeners();
  }

  void resetHistory() {
    player1Wins = 0;
    player2Wins = 0;
    ties = 0;

    notifyListeners();
  }

  void resetGame() {
    for (int i = 0; i < boardState.length; i++) {
      boardState[i] = emptySpot;
    }

    currentTurn = player1;
    winner = 0;
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

  void checkWinner() {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (boardState[i] == player1 &&
          boardState[i + 1] == player1 &&
          boardState[i + 2] == player1) {
        winner = player1;
        notifyListeners();
        return;
      }
      if (boardState[i] == player2 &&
          boardState[i + 1] == player2 &&
          boardState[i + 2] == player2) {
        winner = player2;
        notifyListeners();
        return;
      }
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (boardState[i] == player1 &&
          boardState[i + 3] == player1 &&
          boardState[i + 6] == player1) {
        winner = player1;
        notifyListeners();
        return;
      }
      if (boardState[i] == player2 &&
          boardState[i + 3] == player2 &&
          boardState[i + 6] == player2) {
        winner = player2;
        notifyListeners();
        return;
      }
    }

    // Check for diagonal wins
    if ((boardState[0] == player1 &&
            boardState[4] == player1 &&
            boardState[8] == player1) ||
        (boardState[2] == player1 &&
            boardState[4] == player1 &&
            boardState[6] == player1)) {
      winner = player1;
      notifyListeners();
      return;
    }
    if ((boardState[0] == player2 &&
            boardState[4] == player2 &&
            boardState[8] == player2) ||
        (boardState[2] == player2 &&
            boardState[4] == player2 &&
            boardState[6] == player2)) {
      winner = player2;
      notifyListeners();
      return;
    }

    // Check for tie
    for (int i = 0; i < 9; i++) {
      // If we find a number, then no one has won yet
      if (boardState[i] == emptySpot) {
        winner = 0;
        notifyListeners();
        return;
      }
    }

    // If we make it through the previous loop, all places are taken, so it's a tie
    winner = 3;

    notifyListeners();
  }

  bool canMakeMove() {
    return boardState.any((position) => position == emptySpot);
  }

  void makeTurn(int location) async {
    setMove(location);
    checkWinner();

    //check if is against cpu
    if (isAgainstCPU && canMakeMove() && winner == 0) {
      int cpuLocation = getComputerMove();

      await Future.delayed(const Duration(seconds: 1), () {
        setMove(cpuLocation);
      });
      checkWinner();
    }
  }
}
