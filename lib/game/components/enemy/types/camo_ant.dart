import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class CamoAnt extends BaseEnemy { 
  CamoAnt({required super.waypoints})
      : super(
          antName: "Camo Ant",
          reward: 20,
          speed: 45,
          health: 120,
          spritePath: "sprites/guardia_regina.webp",
          spriteSize: Vector2(70, 70)
        )
        {
      size = Vector2(25, 25);
  }
}
