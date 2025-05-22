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
      enemyColor: const Color(0x4B006E)
  )  
  {
    size = Vector2(5, 15);
  }
}