import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class StagBeeatleTower extends BaseTower 
{
  StagBeeatleTower()
      : super(
          towerName: "Stag Beetle",
          fireRate: 2,
          range: 100,
          damage: 150,
          spritePath: 'sprites/cervo_volante.png',
          spriteSize: Vector2(110, 110),
        );

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
