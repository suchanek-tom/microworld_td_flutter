import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class QueensGuard extends Enemy {
  QueensGuard({required super.waypoints})
      : super(
          reward: 20,
          speed: 10,
          health: 300,
          enemyColor: const Color(0xFF00008B),
        ) {
    size = Vector2(40, 40);
  }
}
