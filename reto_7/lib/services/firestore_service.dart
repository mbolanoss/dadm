import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reto_3/models/game.dart';

import '../models/move.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Game>> getAllGames() async {
    final gamesList = List<Game>.empty(growable: true);

    final gamesRaw = await _firestore.collection('matches').get();

    for (final game in gamesRaw.docs) {
      final newGame = Game.fromJSON(game.data());
      newGame.history = await getAllGameMoves(game.id);
      gamesList.add(newGame);
    }

    return gamesList;
  }

  Future<List<Move>> getAllGameMoves(String gameId) async {
    final movesList = List<Move>.empty(growable: true);

    final movesCollection =
        _firestore.collection('matches').doc(gameId).collection('history');
    final movesRaw = await movesCollection.get();

    for (final move in movesRaw.docs) {
      movesList.add(Move.fromJSON(move.data()));
    }

    return List.from(movesList.reversed);
  }
}
