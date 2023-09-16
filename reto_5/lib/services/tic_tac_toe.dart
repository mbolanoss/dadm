import 'dart:math';

import 'package:flutter/material.dart';

enum Difficulty { easy, harder, expert }

class TicTacToe with ChangeNotifier {
  final boardState = List.filled(9, emptySpot);
  List<int> winnerPositions = List.filled(3, -1);
  final cpuPlayTime = 2;

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;
  Difficulty currentDifficulty = Difficulty.easy;

  int currentTurn = player1;
  bool isAgainstCPU = true;
  int winner = 0;

  int player1Wins = 0;
  int player2Wins = 0;
  int ties = 0;

  void changeDifficulty(Difficulty newDiff) {
    currentDifficulty = newDiff;
    notifyListeners();
  }

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
      location = getComputerRandomMove();
    }
    // Winning -> random
    else if (currentDifficulty == Difficulty.harder) {
      final winningMove = getComputerSmartMove(true);

      location = winningMove != -1 ? winningMove : getComputerRandomMove();
    }
    // Winning -> blocking -> random
    else if (currentDifficulty == Difficulty.expert) {
      final winningMove = getComputerSmartMove(true);
      final blockingMove = getComputerSmartMove(false);

      location = winningMove != -1
          ? winningMove
          : blockingMove != -1
              ? blockingMove
              : getComputerRandomMove();
    }

    return location;
  }

  int getComputerRandomMove() {
    int location = -1;
    Random random = Random();

    while (true) {
      location = random.nextInt(9);

      if (boardState[location] == emptySpot) {
        return location;
      }
    }
  }

  int getComputerSmartMove(bool isWinningMove) {
    final tempState = List.from(boardState);
    final otherPlayer = isWinningMove ? player2 : player1;
    int tempWinner = 0;

    for (int i = 0; i < 9; i++) {
      int prevBoxState = tempState[i];
      if (tempState[i] == emptySpot) {
        tempState[i] = otherPlayer;
        tempWinner = checkWinner(tempState, otherPlayer)[0];
        if (tempWinner == otherPlayer) {
          return i;
        }

        tempState[i] = prevBoxState;
      }
    }

    return -1;
  }

  // returns [winner, pos1, pos2, pos3]
  List<int> checkWinner(state, turn) {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (state[i] == turn && state[i + 1] == turn && state[i + 2] == turn) {
        return [turn, i, i + 1, i + 2];
      }
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (state[i] == turn && state[i + 3] == turn && state[i + 6] == turn) {
        return [turn, i, i + 3, i + 6];
      }
    }

    // Check for diagonal wins
    if ((state[0] == turn && state[4] == turn && state[8] == turn)) {
      return [turn, 0, 4, 8];
    }
    if ((state[2] == turn && state[4] == turn && state[6] == turn)) {
      return [turn, 2, 4, 6];
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
    List<int> winnerStatus = checkWinner(boardState, currentTurn);
    winner = winnerStatus[0];
    winnerPositions = winnerStatus.sublist(1, 4);

    // next turn
    currentTurn = currentTurn == player1 ? player2 : player1;
    notifyListeners();

    //check if is against cpu
    if (isAgainstCPU && canMakeMove() && winner == 0) {
      int cpuLocation = getComputerMove();

      await Future.delayed(Duration(seconds: cpuPlayTime), () {
        setMove(cpuLocation);

        // Update winner info
        List<int> winnerStatus = checkWinner(boardState, currentTurn);
        winner = winnerStatus[0];
        winnerPositions = winnerStatus.sublist(1, 4);

        // next turn
        currentTurn = currentTurn == player1 ? player2 : player1;
        notifyListeners();
      });
    }
  }
}
