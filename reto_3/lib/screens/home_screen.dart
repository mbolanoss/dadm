import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_3/services/tic_tac_toe.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  HomeScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 60, 79),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
            screenSize.width * 0.13,
            screenSize.height * 0.07,
            screenSize.width * 0.13,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Title
              const Title(),

              SizedBox(height: screenSize.height * 0.06),

              // Board
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: ticTacToe.boardState.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return NumberBox(position: i);
                  }),
              SizedBox(height: screenSize.height * 0.06),
              // Turn text
              Text(
                ticTacToe.currentTurn == TicTacToe.player1
                    ? 'Turno de: Jugador 1'
                    : 'Turno de: Jugador 2',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),

              SizedBox(
                height: screenSize.height * 0.02,
              ),

              // Reset btn
              SizedBox(
                width: screenSize.width * 0.4,
                child: ElevatedButton(
                  onPressed: () => ticTacToe.resetGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 241, 197, 6),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Winner text
              Text(
                ticTacToe.winner == 0
                    ? ''
                    : ticTacToe.winner == 1
                        ? 'Ganador: Jugador 1'
                        : ticTacToe.winner == 2
                            ? 'Ganador: Jugador 2'
                            : 'Empate',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )),
      ),
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

class NumberBox extends StatelessWidget {
  const NumberBox({
    super.key,
    required this.position,
  });

  final int position;
  static const BorderSide border =
      BorderSide(color: Color.fromARGB(255, 0, 155, 255), width: 4);

  @override
  Widget build(BuildContext context) {
    final ticTacToe = context.watch<TicTacToe>();
    return GridTile(
      child: Container(
        decoration: BoxDecoration(border: getBorder(position)),
        child: TextButton(
            onPressed: ticTacToe.boardState[position] == TicTacToe.emptySpot &&
                    ticTacToe.winner == 0
                ? () {
                    ticTacToe.makeTurn(position);
                  }
                : null,
            child: Text(
              ticTacToe.boardState[position] == 0
                  ? '-'
                  : ticTacToe.boardState[position] == 1
                      ? 'X'
                      : 'O',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }

  BoxBorder getBorder(int position) {
    switch (position) {
      case 0:
        return const BorderDirectional(bottom: border, end: border);
      case 1:
        return const BorderDirectional(bottom: border, end: border);
      case 2:
        return const BorderDirectional(bottom: border);
      case 3:
        return const BorderDirectional(bottom: border, end: border);
      case 4:
        return const BorderDirectional(bottom: border, end: border);
      case 5:
        return const BorderDirectional(bottom: border);
      case 6:
        return const BorderDirectional(end: border);
      case 7:
        return const BorderDirectional(end: border);
      case 8:
        return const BorderDirectional();
      default:
        return const BorderDirectional();
    }
  }
}
