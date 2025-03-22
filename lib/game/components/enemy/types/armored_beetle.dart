import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class ArmoredBeetle extends Enemy {
  ArmoredBeetle({required List<Vector2> waypoints})
      : super(
          waypoints: waypoints,
          reward: 10,
          speed: 4,
          health: 100,
          enemyColor: const Color(0xFF555555),
        ) {
    size = Vector2(30, 30);
  }
}
