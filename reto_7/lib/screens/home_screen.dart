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
            child: FutureBuilder(
              future: firestoreService.getAllGames(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return HomeBody(snapshot: snapshot);
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
  final AsyncSnapshot<List<Game>> snapshot;

  const HomeBody({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Title(),
        const SizedBox(height: 20),
        ListView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return GameTile(
                game: snapshot.data!.elementAt(index), gameNumber: index + 1);
          },
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
