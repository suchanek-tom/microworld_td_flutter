import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class FastBug extends Enemy {
  FastBug({required List<Vector2> waypoints})
      : super(waypoints: waypoints, speed: 30, health: 30) {
    size = Vector2(10, 10);
    enemyColor = const Color(0xFFFF0000);
  }
}
