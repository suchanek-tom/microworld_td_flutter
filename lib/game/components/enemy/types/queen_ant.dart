import 'package:flame/extensions.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class QueenAnt extends BaseEnemy
{
  QueenAnt({required super.waypoints})
  : super(
      health: 1000,
      speed: 30,
      reward: 150,
      spritePath: "sprites/formica_regina.png",
      spriteSize: Vector2(140, 140))
      {
      size = Vector2(70, 70);
  }
}