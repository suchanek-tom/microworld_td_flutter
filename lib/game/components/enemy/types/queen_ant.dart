import 'dart:ui';

import 'package:flame/extensions.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class QueenAnt extends BaseEnemy
{
  QueenAnt({required super.waypoints})
  : super(
      health: 1000,
      speed: 5,
      reward: 150,
      spritePath: 'formica.png',
          spriteSize: Vector2(30, 30),
  )  
  {
    size = Vector2(5, 15);
  }
}