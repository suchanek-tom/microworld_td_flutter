import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BeeTower extends BaseTower {
  BeeTower({required Vector2 position})
      : super(
          position: position,
          fireRate: 0.3,
          range: 200,
          damage: 5,
          spritePath: 'assets/img/sprites/bee.png',
          spriteSize: Vector2(36, 36),
        );

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
