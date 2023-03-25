import 'package:flutter/material.dart';
import 'dart:math';

import 'package:worm_game/snake_painter.dart';

import 'direction.dart';

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  Random random = new Random();
  late Offset foodPosition;
  late List<Offset> snakePositions;
  Direction direction = Direction.right;

  @override
  void initState() {
    super.initState();
    _generateFoodPosition();
    snakePositions = [Offset(150.0, 150.0)];
  }

  void _generateFoodPosition() {
    foodPosition = Offset(
      random.nextInt(300).toDouble(),
      random.nextInt(300).toDouble(),
    );
  }

  void _drawSnake(Canvas canvas) {
    for (var i = 0; i < snakePositions.length; i++) {
      canvas.drawRect(
        Rect.fromPoints(
          snakePositions[i],
          Offset(
            snakePositions[i].dx + 10.0,
            snakePositions[i].dy + 10.0,
          ),
        ),
        Paint()..color = Colors.green,
      );
    }
  }

  void _updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePositions.insert(
            0,
            Offset(snakePositions.first.dx, snakePositions.first.dy - 10.0),
          );
          break;
        case Direction.right:
          snakePositions.insert(
            0,
            Offset(snakePositions.first.dx + 10.0, snakePositions.first.dy),
          );
          break;
        case Direction.down:
          snakePositions.insert(
            0,
            Offset(snakePositions.first.dx, snakePositions.first.dy + 10.0),
          );
          break;
        case Direction.left:
          snakePositions.insert(
            0,
            Offset(snakePositions.first.dx - 10.0, snakePositions.first.dy),
          );
          break;
      }

      if (snakePositions.first == foodPosition) {
        _generateFoodPosition();
      } else {
        snakePositions.removeLast();
      }
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0 && direction != Direction.left) {
      direction = Direction.right;
    } else if (details.delta.dx < 0 && direction != Direction.right) {
      direction = Direction.left;
    } else if (details.delta.dy > 0 && direction != Direction.up) {
      direction = Direction.down;
    } else if (details.delta.dy < 0 && direction != Direction.down) {
      direction = Direction.up;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300.0,
        height: 300.0,
        color: Colors.grey,
        child: Stack(
          children: [
            CustomPaint(
              painter: SnakePainter(
                drawSnake: _drawSnake,
                foodPosition: foodPosition,
              ),
              size: Size(300.0, 300.0),
            ),
            GestureDetector(
              onPanUpdate: _onPanUpdate,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
