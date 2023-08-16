import 'dart:math';

class TicTacToe {
  final boardState = List.filled(9, emptySpot);

  static const emptySpot = 0;
  static const player1 = 1;
  static const player2 = 2;

  TicTacToe() {}

  void clearBoard() {
    for (int i = 0; i < boardState.length; i++) {
      boardState[i] = emptySpot;
    }
  }

  // true if location is available, false otherwise
  bool setMove(int player, int location) {
    if (boardState[location] == emptySpot) {
      return false;
    } else {
      boardState[location] = player;
      return true;
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
