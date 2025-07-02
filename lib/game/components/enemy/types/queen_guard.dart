import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class QueenGuard extends BaseEnemy { //This class can be managed by a larger class, called queen ant
  QueenGuard({required super.waypoints})
      : super(
          antName: "Queen Guard",
          reward: 20,
          speed: 10,
          health: 300,
          spritePath: "sprites/formica.webp",
          spriteSize: Vector2(70, 70)
        )
        {
      size = Vector2(35, 35);
  }
}
