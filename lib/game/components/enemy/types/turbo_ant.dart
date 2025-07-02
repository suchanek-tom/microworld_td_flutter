import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class TurboAnt extends BaseEnemy {
  TurboAnt({required super.waypoints})
      : super(
          antName: "Turbo Ant",
          reward: 3,
          speed: 30,
          health: 30,
          spritePath: "sprites/formica.webp",
          spriteSize: Vector2(70, 70)
        )
        {
      size = Vector2(35, 35);
  }
}
