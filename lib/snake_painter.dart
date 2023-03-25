import 'package:flutter/material.dart';

class SnakePainter extends CustomPainter {
  final Function(Canvas) drawSnake;
  final Offset foodPosition;

  SnakePainter({required this.drawSnake, required this.foodPosition});

  @override
  void paint(Canvas canvas, Size size) {
    drawSnake(canvas);
    canvas.drawRect(
      Rect.fromPoints(
        foodPosition,
        Offset(foodPosition.dx + 10.0, foodPosition.dy + 10.0),
      ),
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(SnakePainter oldDelegate) {
    return true;
  }
}
