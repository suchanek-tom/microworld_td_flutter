import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class TurboAnt extends BaseEnemy {
  TurboAnt({required super.waypoints})
      : super(
          antName: "Turbo Ant",
          reward: 20,
          speed: 120,
          health: 250,
          spritePath: "sprites/formica_turbo.webp",
          spriteSize: Vector2(70, 70)
        )
        {
      size = Vector2(50, 50);
  }
}
