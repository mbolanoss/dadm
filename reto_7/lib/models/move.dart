class Move {
  String? playerId;
  int? position;

  Move({
    required this.playerId,
    required this.position,
  });

  Move.fromJSON(Map<String, dynamic> json) {
    playerId = json['player_id'];
    position = json['position'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'player_id': playerId,
      'position': position,
    };
  }
}
