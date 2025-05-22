import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class ArmoredAnt extends BaseEnemy {
  ArmoredAnt({required super.waypoints})
      : super(
          reward: 10,
          speed: 2,
          health: 100,
          spritePath: "sprites/formica.png",
          spriteSize: Vector2(70, 70)
          
        ) {
    size = Vector2(30, 30);
  }
}
