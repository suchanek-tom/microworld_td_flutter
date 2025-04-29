import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class QueensGuard extends BaseEnemy { //This class can be managed by a larger class, called queen ant
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
