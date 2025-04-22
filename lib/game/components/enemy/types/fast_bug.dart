import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class FastBug extends BaseEnemy {
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
