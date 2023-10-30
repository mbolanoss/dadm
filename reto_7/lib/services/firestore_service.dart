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

  Future<void> updateScore({
    required int player1Wins,
    required int player2Wins,
    required int ties,
    required String turn,
    required String gameId,
  }) async {
    await _firestore.collection('matches').doc(gameId).update({
      'player1_wins': player1Wins,
      'player2_wins': player2Wins,
      'ties': ties,
      'turn': turn
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

  Future<void> resetGame(String turn, String gameId) async {
    // Reiniciar tablero
    final movesCollection = await _firestore
        .collection('matches')
        .doc(gameId)
        .collection('history')
        .get();

    for (var doc in movesCollection.docs) {
      _firestore
          .collection('matches')
          .doc(gameId)
          .collection('history')
          .doc(doc.id)
          .delete();
    }

    // Reiniciar turno
    await _firestore.collection('matches').doc(gameId).update({'turn': turn});
  }

  Future<void> changeTurn(String gameId, String newTurn) async {
    await _firestore.collection('matches').doc(gameId).update({
      'turn': newTurn,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGameInfoStream(
      String gameId) {
    return _firestore.collection('matches').doc(gameId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGameHistoryStream(
      String gameId) {
    return _firestore
        .collection('matches')
        .doc(gameId)
        .collection('history')
        .snapshots();
  }

  Future<void> sendWinner(String gameId, String winner) async {
    await _firestore.collection('matches').doc(gameId).update({
      'turn': winner,
    });
  }

  List<Move> getMovesListFromDoc(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final movesList = List<Move>.empty(growable: true);
    for (final doc in snapshot.docs) {
      final newMove = Move(
          playerId: doc.data()['player_id'], position: doc.data()['position']);
      movesList.add(newMove);
    }

    return movesList;
  }

  Game getGameStatus(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final doc = snapshot.data();
    final player1wins = doc!['player1_wins'];
    final player2wins = doc['player2_wins'];
    final ties = doc['ties'];
    final turn = doc['turn'];

    final gameStatus = Game.status(
        player1wins: player1wins,
        player2wins: player2wins,
        ties: ties,
        turn: turn);

    return gameStatus;
  }
}
