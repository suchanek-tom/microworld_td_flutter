import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class ArmoredAnt extends BaseEnemy {
  ArmoredAnt({required super.waypoints})
      : super(
          reward: 10,
          speed: 20,
          health: 400,
          spritePath: "sprites/formica_corazzata.webp",
          spriteSize: Vector2(70, 70)
        ) 
        {
    size = Vector2(40, 40);
  }
}
