import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto_3/services/firestore_service.dart';
import 'package:reto_3/widgets/game_tile.dart';

import '../models/game.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 60, 79),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Center(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestoreService.getGamesListStream(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return HomeBody(snapshot: snapshot.data!);
                } else if (snapshot.hasError) {
                  return const Text('Error cargando las partidas');
                } else {
                  return const CircularProgressIndicator(
                    color: Color.fromARGB(255, 241, 197, 6),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final QuerySnapshot<Map<String, dynamic>> snapshot;
  final firestoreService = FirestoreService();

  HomeBody({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Title(),
        const SizedBox(height: 20),
        snapshot.docs.isNotEmpty
            ? FutureBuilder<List<Game>>(
                future: firestoreService.getAllGames(snapshot),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, __) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            height: 3,
                          );
                        },
                        itemCount: futureSnapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return GameTile(
                              game: futureSnapshot.data!.elementAt(index),
                              gameNumber: index + 1);
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  }
                },
              )
            : const Text(
                'Ups! No hay partidas creadas',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            firestoreService.createGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 241, 197, 6),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'Crear partida',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'TicTacToe',
          style: TextStyle(
            fontSize: 38,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: screenSize.width * 0.4,
          height: 4,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        )
      ],
    );
  }
}
