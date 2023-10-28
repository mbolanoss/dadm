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
      newGame.id = game.id;
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

  Future<void> sendMove(Move move, String gameId) async {
    final moveJson = move.toJSON();

    await _firestore
        .collection('matches')
        .doc(gameId)
        .collection('history')
        .add(moveJson);
  }

  Future<void> saveGame(Game game) async {
    await _firestore.collection('matches').doc(game.id).update({
      'player1_wins': game.player1wins,
      'player2_wins': game.player2wins,
      'ties': game.ties,
      'turn': game.turn
    });
  }

  Future<void> resetScore(
    String gameId,
  ) async {
    await _firestore.collection('matches').doc(gameId).update({
      'player1_wins': 0,
      'player2_wins': 0,
      'ties': 0,
    });
  }

  Future<void> resetGame() async {}

  Future<void> changeTurn(String gameId, String newTurn) async {
    await _firestore.collection('matches').doc(gameId).update({
      'turn': newTurn,
    });
  }

  Future<String> getCurrentTurn(String gameId) async {
    final gameData = await _firestore.collection('matches').doc(gameId).get();

    return gameData.data()!['turn'];
  }

  String getCurrentTurnFromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return doc.data()!['turn'];
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getTurnStream(String gameId) {
    return _firestore.collection('matches').doc(gameId).snapshots();
  }
}
