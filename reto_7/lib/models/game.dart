import 'package:reto_3/models/move.dart';

class Game {
  String? player1Id;
  String? player2Id;
  List<Move>? history;

  Game({
    required this.player1Id,
    required this.player2Id,
    required this.history,
  });

  Game.fromJSON(Map<String, dynamic> json) {
    player1Id = json['player1_id'];
    player2Id = json['player2_id'];
    // history = Move.fromJSON(json['history']);
  }
}
