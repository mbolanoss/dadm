import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/models/game.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

class GameTile extends StatelessWidget {
  final Game game;
  final int gameNumber;
  const GameTile({super.key, required this.game, required this.gameNumber});

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.read<TicTacToe>();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          // Numero de juego
          Text(
            'Juego #$gameNumber',
            style: const TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Puntaje
          Text(
            'Puntaje: J1: ${game.player1wins} J2: ${game.player2wins} E: ${game.ties}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            ticTacToe.deviceId == game.turn!
                ? 'Turno: Jugador 1'
                : 'Turno: Jugador 2',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          // Play button
          ElevatedButton(
            onPressed: () {
              ticTacToe.loadGame(game);
              Navigator.pushNamed(context, '/game');
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
              'Jugar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
