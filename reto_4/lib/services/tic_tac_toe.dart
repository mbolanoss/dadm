import 'dart:math';

import 'package:flutter/material.dart';

enum Difficulty { easy, harder, expert }

class TicTacToe with ChangeNotifier {
  final boardState = List.filled(9, emptySpot);
  final winnerPositions = List.filled(3, -1);

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;
  static Difficulty currentDifficulty = Difficulty.easy;

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

    for (int i = 0; i < winnerPositions.length; i++) {
      winnerPositions[i] = -1;
    }

    currentTurn = player1;
    winner = 0;
    currentDifficulty = Difficulty.easy;
    notifyListeners();
  }

  // true if location is available, false otherwise
  void setMove(int location) {
    if (boardState.any((position) => position == emptySpot)) {
      if (boardState[location] == emptySpot) {
        boardState[location] = currentTurn;

        notifyListeners();
      }
    }
  }

  int getComputerMove() {
    int location = -1;

    // Random move
    if (currentDifficulty == Difficulty.easy) {
      Random random = Random();

      while (true) {
        location = random.nextInt(9);

        if (boardState[location] == emptySpot) {
          return location;
        }
      }
    }
    // Winning move
    else if (currentDifficulty == Difficulty.harder) {
    }
    // Winning and blocking move
    else if (currentDifficulty == Difficulty.expert) {}

    return -1;
  }

  int getComputerWinningMove() {
    int location = -1;

    // Check horizontal win
    for (int i = 0; i <= 6; i += 3) {
      final line = [boardState[i], boardState[i + 1], boardState[i + 2]];

      for (int j = 0; j < 2; j++) {}
    }

    return location;
  }

  void checkWinner(state) {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (state[i] == currentTurn &&
          state[i + 1] == currentTurn &&
          state[i + 2] == currentTurn) {
        winnerPositions[0] = i;
        winnerPositions[1] = i + 1;
        winnerPositions[2] = i + 2;

        winner = currentTurn;
        return;
      }
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (state[i] == currentTurn &&
          state[i + 3] == currentTurn &&
          state[i + 6] == currentTurn) {
        winnerPositions[0] = i;
        winnerPositions[1] = i + 3;
        winnerPositions[2] = i + 6;

        winner = currentTurn;
        return;
      }
    }

    // Check for diagonal wins
    if ((state[0] == currentTurn &&
        state[4] == currentTurn &&
        state[8] == currentTurn)) {
      winnerPositions[0] = 0;
      winnerPositions[1] = 4;
      winnerPositions[2] = 8;

      winner = currentTurn;
      return;
    }
    if ((state[2] == currentTurn &&
        state[4] == currentTurn &&
        state[6] == currentTurn)) {
      winnerPositions[0] = 2;
      winnerPositions[1] = 4;
      winnerPositions[2] = 6;
      winner = currentTurn;
      return;
    }

    // Check for tie
    for (int i = 0; i < 9; i++) {
      // If we find a number, then no one has won yet
      if (state[i] == emptySpot) {
        winner = 0;
        return;
      }
    }

    // If we make it through the previous loop, all places are taken, so it's a tie
    winner = 3;
  }

  bool canMakeMove() {
    return boardState.any((position) => position == emptySpot);
  }

  void makeTurn(int location) async {
    setMove(location);
    checkWinner(boardState);
    // next turn
    currentTurn = currentTurn == player1 ? player2 : player1;
    notifyListeners();

    //check if is against cpu
    if (isAgainstCPU && canMakeMove() && winner == 0) {
      int cpuLocation = getComputerMove();

      await Future.delayed(const Duration(seconds: 1), () {
        setMove(cpuLocation);
      });
      checkWinner(boardState);
      // next turn
      currentTurn = currentTurn == player1 ? player2 : player1;
      notifyListeners();
    }
  }
}
