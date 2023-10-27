import 'package:reto_3/models/move.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

class Game {
  String? player1Id;
  String? player2Id;
  List<Move>? history;
  int? player1wins;
  int? player2wins;
  int? ties;
  int? turn;
  Difficulty? difficulty;

  Game({
    required this.player1Id,
    required this.player2Id,
    required this.history,
    required this.player1wins,
    required this.player2wins,
    required this.ties,
    required this.difficulty,
    required this.turn,
  });

  Game.fromJSON(Map<String, dynamic> json) {
    player1Id = json['player1_id'];
    player2Id = json['player2_id'];
    player1wins = json['player1_wins'];
    player2wins = json['player2_wins'];
    ties = json['ties'];
    turn = json['turn'];

    final numDifficulty = json['difficulty'];
    difficulty = numDifficulty == 1
        ? Difficulty.easy
        : numDifficulty == 2
            ? Difficulty.expert
            : Difficulty.harder;
  }
}
