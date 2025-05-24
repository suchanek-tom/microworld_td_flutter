import 'package:flame/extensions.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class QueenAnt extends BaseEnemy
{
  QueenAnt({required super.waypoints})
  : super(
      health: 1000,
      speed: 5,
      reward: 150,
      spritePath: "sprites/formica.png",
      spriteSize: Vector2(70, 70)
  );
}