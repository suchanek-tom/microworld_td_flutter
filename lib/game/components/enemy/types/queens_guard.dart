import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class QueensGuard extends Enemy {
  QueensGuard({required List<Vector2> waypoints})
      : super(waypoints: waypoints, speed: 10, health: 300) {
    size = Vector2(40, 40);
    enemyColor = const Color(0xFF00008B);
  }
}
