import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:flame/components.dart';

class WorkerAnt extends BaseEnemy {
  WorkerAnt({required super.waypoints})
      : super(
          antName: "Worker Ant",
          reward: 15,
          speed: 45,
          health: 100,
          spritePath: "sprites/formica.webp",
          spriteSize: Vector2(70, 70),
        ){
    size = Vector2(35, 35);
  }
}