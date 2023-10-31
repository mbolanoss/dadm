import 'package:reto_3/models/move.dart';

class Game {
  String? id;
  String? player1Id;
  String? player2Id;
  List<Move>? history;
  int? player1wins;
  int? player2wins;
  int? ties;
  String? turn;

  Game({
    this.id,
    this.player1Id,
    this.player2Id,
    this.history,
    this.player1wins,
    this.player2wins,
    this.ties,
    this.turn,
  });

  Game.status({
    required this.player1wins,
    required this.player2wins,
    required this.ties,
    required this.turn,
  });

  Game.fromJSON(Map<String, dynamic> json) {
    player1Id = json['player1_id'];
    player2Id = json['player2_id'];
    player1wins = json['player1_wins'];
    player2wins = json['player2_wins'];
    ties = json['ties'];
    turn = json['turn'];
  }

  Map<String, dynamic> toJson() {
    return {
      'player1_id': player1Id,
      'player1_wins': player1wins,
      'player2_id': player2Id,
      'player2_wins': player2wins,
      'ties': ties,
      'turn': turn
    };
  }
}
