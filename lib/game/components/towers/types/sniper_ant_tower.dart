import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class SniperAntTower extends BaseTower {
  SniperAntTower({required super.position})
      : super(
          fireRate: 0.5,
          range: 300,
          damage: 10,
          spritePath: 'bee.png',
          spriteSize: Vector2(40, 40),
        );

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
