import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class TurboAnt extends BaseEnemy {
  TurboAnt({required super.waypoints})
      : super(
          reward: 3,
          speed: 30,
          health: 30,
          spritePath: 'formica.png',
          spriteSize: Vector2(20, 20),
        ) {
    size = Vector2(10, 10);
  }
}
