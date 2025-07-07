import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class ArmoredAnt extends BaseEnemy {
  ArmoredAnt({required super.waypoints})
      : super(
          antName: "Armored Ant",
          reward: 50,
          speed: 35,
          health: 1000,
          spritePath: "sprites/formica_corazzata.webp",
          spriteSize: Vector2(70, 70)
        ) 
      {
    size = Vector2(60, 60);
  }
}
