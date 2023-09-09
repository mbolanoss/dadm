import 'dart:math';

import 'package:flutter/material.dart';

enum Difficulty { easy, harder, expert }

class TicTacToe with ChangeNotifier {
  final boardState = List.filled(9, emptySpot);
  List<int> winnerPositions = List.filled(3, -1);

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

    getComputerWinningMove();

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
    final tempState = List.from(boardState);
    int tempWinner = 0;

    for (int i = 0; i < 9; i++) {
      int prevBoxState = tempState[i];
      if (tempState[i] == emptySpot) {
        tempState[i] = player2;
        tempWinner = checkWinner(tempState)[0];
        if (tempWinner == player2) {
          return i;
        }

        tempState[i] = prevBoxState;
      }
    }

    return -1;
  }

  // returns [winner, pos1, pos2, pos3]
  List<int> checkWinner(state) {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (state[i] == currentTurn &&
          state[i + 1] == currentTurn &&
          state[i + 2] == currentTurn) {
        return [currentTurn, i, i + 1, i + 2];
      }
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (state[i] == currentTurn &&
          state[i + 3] == currentTurn &&
          state[i + 6] == currentTurn) {
        return [currentTurn, i, i + 3, i + 6];
      }
    }

    // Check for diagonal wins
    if ((state[0] == currentTurn &&
        state[4] == currentTurn &&
        state[8] == currentTurn)) {
      return [currentTurn, 0, 4, 8];
    }
    if ((state[2] == currentTurn &&
        state[4] == currentTurn &&
        state[6] == currentTurn)) {
      return [currentTurn, 2, 4, 6];
    }

    // Check for tie
    for (int i = 0; i < 9; i++) {
      // If we find a number, then no one has won yet
      if (state[i] == emptySpot) {
        return [0, -1, -1, -1];
      }
    }

    // If we make it through the previous loop, all places are taken, so it's a tie
    return [3, -1, -1, -1];
  }

  bool canMakeMove() {
    return boardState.any((position) => position == emptySpot);
  }

  void makeTurn(int location) async {
    setMove(location);

    // Update winner info
    List<int> winnerStatus = checkWinner(boardState);
    winner = winnerStatus[0];
    winnerPositions = winnerStatus.sublist(1, 4);

    // next turn
    currentTurn = currentTurn == player1 ? player2 : player1;
    notifyListeners();

    //check if is against cpu
    if (isAgainstCPU && canMakeMove() && winner == 0) {
      int cpuLocation = getComputerMove();

      await Future.delayed(const Duration(seconds: 1), () {
        setMove(cpuLocation);

        // Update winner info
        List<int> winnerStatus = checkWinner(boardState);
        winner = winnerStatus[0];
        winnerPositions = winnerStatus.sublist(1, 4);

        // next turn
        currentTurn = currentTurn == player1 ? player2 : player1;
        notifyListeners();
      });
    }
  }
}
