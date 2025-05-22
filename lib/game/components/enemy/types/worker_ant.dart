import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class WorkerAnt extends BaseEnemy {
  WorkerAnt({required super.waypoints})
      : super(
          reward: 5,
          speed: 20,
          health: 40,
          enemyColor: const Color(0xFF964B00),
        ) {
    size = Vector2(20, 20);
  }
}
