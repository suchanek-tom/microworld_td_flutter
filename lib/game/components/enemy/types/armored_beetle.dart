import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class ArmoredBeetle extends BaseEnemy {
  ArmoredBeetle({required List<Vector2> waypoints})
      : super(
          waypoints: waypoints,
          reward: 10,
          speed: 2,
          health: 100,
          enemyColor: const Color(0xFF555555),
        ) {
    size = Vector2(30, 30);
  }
}
