import 'package:flutter/material.dart';
import 'package:reto_3/screens/game_screen.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CustomPaint(
      // ignore: prefer_const_constructors
      // size: Size(double.infinity, double.infinity),
      painter: LinesPainter(screenSize),
      child: const Boxes(),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Size screenSize;

  const LinesPainter(this.screenSize);
  @override
  void paint(Canvas canvas, Size size) {
    final verticalDiv = size.width / 3;
    final horizontalDiv = size.height / 3;

    final paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 4;

    for (int i = 0; i < 4; i++) {
      Offset verticalP1 = Offset(verticalDiv * i, 0);
      Offset verticalP2 = Offset(verticalDiv * i, size.height);
      Offset horizontalP1 = Offset(0, horizontalDiv * i);
      Offset horizontalP2 = Offset(size.width, horizontalDiv * i);

      canvas.drawLine(verticalP1, verticalP2, paint);
      canvas.drawLine(horizontalP1, horizontalP2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
