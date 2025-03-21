import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class WorkerAnt extends Enemy {
  WorkerAnt({required List<Vector2> waypoints})
      : super(waypoints: waypoints, speed: 20, health: 40) {
    size = Vector2(20, 20);
    enemyColor = const Color(0xFF964B00);
  }
}
