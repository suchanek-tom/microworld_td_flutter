import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class QueenGuard extends BaseEnemy { //This class can be managed by a larger class, called queen ant
  QueenGuard({required super.waypoints})
      : super(
          antName: "Queen Guard",
          reward: 10,
          speed: 50,
          health: 90,
          spritePath: "sprites/guardia_regina.webp",
          spriteSize: Vector2(70, 70)
        )
        {
      size = Vector2(25, 25);
  }
}
