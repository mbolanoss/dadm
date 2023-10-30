import 'package:flutter/material.dart';
import 'package:reto_3/models/game.dart';
import 'package:reto_3/models/move.dart';
import 'package:reto_3/services/firestore_service.dart';

class TicTacToe with ChangeNotifier {
  late String deviceId;

  final firestoreService = FirestoreService();
  String? gameId;
  String? player1Id;
  String? player2Id;

  final boardState = List.filled(9, emptySpot);
  List<int> winnerPositions = List.filled(3, -1);

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;

  int winner = 0;

  int player1Wins = 0;
  int player2Wins = 0;
  int ties = 0;

  String currentTurn = '';

  void loadGame(Game game) {
    gameId = game.id;
    player1Wins = game.player1wins!;
    player1Id = game.player1Id;
    player2Id = game.player2Id;
    player2Wins = game.player2wins!;
    ties = game.ties!;
    currentTurn = game.turn!;

    for (final move in game.history!) {
      if (move.playerId! == game.player1Id) {
        boardState[move.position!] = player1;
      } else if (move.playerId! == game.player2Id) {
        boardState[move.position!] = player2;
      }
    }

    notifyListeners();
  }

  void updateBoardState(List<Move> moves) {
    for (final move in moves) {
      if (move.playerId! == player1Id) {
        boardState[move.position!] = player1;
      } else if (move.playerId! == player2Id) {
        boardState[move.position!] = player2;
      }
    }
  }

  void updateGameStatus(Game game) {
    winner = game.turn == 'win1'
        ? player1
        : game.turn == 'win2'
            ? 2
            : game.turn == 'tie'
                ? 3
                : 0;

    player1Wins = game.player1wins!;
    player2Wins = game.player2wins!;
    ties = game.ties!;

    currentTurn = game.turn!;
  }

  void updateScore() {
    player1Wins = winner == 1 ? player1Wins + 1 : player1Wins;
    player2Wins = winner == 2 ? player2Wins + 1 : player2Wins;
    ties = winner == 3 ? ties + 1 : ties;

    notifyListeners();
  }

  void resetScore() {
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

    winner = 0;
    notifyListeners();
  }

  // true if location is available, false otherwise
  void setMove(int location) {
    if (boardState.any((position) => position == emptySpot)) {
      if (boardState[location] == emptySpot) {
        boardState[location] = currentTurn == player1Id ? player1 : player2;

        final move = Move(playerId: currentTurn, position: location);
        firestoreService.sendMove(move, gameId!);

        notifyListeners();
      }
    }
  }

  // returns [winner, pos1, pos2, pos3]
  List<int> checkWinner(List<int> state, int turn) {
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

  void makeTurn(int location) async {
    setMove(location);

    // Update winner info
    final currentTurnNumber = currentTurn == deviceId ? player1 : player2;

    List<int> winnerStatus = checkWinner(boardState, currentTurnNumber);
    winner = winnerStatus[0];
    winnerPositions = winnerStatus.sublist(1, 4);

    if (winner != 0) {
      final winnerStr = winner == player1
          ? 'win1'
          : winner == player2
              ? 'win2'
              : 'tie';
      await firestoreService.sendWinner(gameId!, winnerStr);
    } else {
      // next turn
      currentTurn = currentTurn == player1Id! ? player2Id! : player1Id!;
      await firestoreService.changeTurn(gameId!, currentTurn);
    }
    notifyListeners();
  }

  bool isTurnAvailable() {
    return deviceId == currentTurn;
  }

  void updateWinner(List<int> winnerInfo) {
    winner = winnerInfo[0];
    winnerPositions = winnerInfo.sublist(1);
  }
}
