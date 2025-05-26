import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BlackWidowTower extends BaseTower {
  BlackWidowTower()
      : super(
          fireRate: 0.5,
          range: 300,
          damage: 10,
          spritePath: 'sprites/vedova_nera.png',
          spriteSize: Vector2(90, 90),
        );

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
