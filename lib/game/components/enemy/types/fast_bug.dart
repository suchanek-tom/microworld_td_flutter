import '../enemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class FastBug extends Enemy {
  FastBug({required super.waypoints})
      : super(
          reward: 3,
          speed: 30,
          health: 30,
          enemyColor: const Color(0xFFFF0000),
        ) {
    size = Vector2(10, 10);
  }
}
