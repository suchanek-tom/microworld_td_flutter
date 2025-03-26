import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class FastBug extends BaseEnemy {
  FastBug({required List<Vector2> waypoints})
      : super(
          waypoints: waypoints,
          reward: 3,
          speed: 30,
          health: 30,
          enemyColor: const Color(0xFFFF0000),
        ) {
    size = Vector2(10, 10);
  }
}
