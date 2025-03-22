import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class QueensGuard extends Enemy {
  QueensGuard({required List<Vector2> waypoints})
      : super(
          waypoints: waypoints,
          reward: 20,
          speed: 10,
          health: 300,
          enemyColor: const Color(0xFF00008B),
        ) {
    size = Vector2(40, 40);
  }
}
