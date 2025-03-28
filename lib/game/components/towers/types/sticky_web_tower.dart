import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class StickyWebTower extends BaseTower {
  StickyWebTower({required Vector2 position})
   :  super(
      position: position,
      fireRate: 0.5,
      range: 150,
      damage: 10,
      towerColor: const Color(0xFF800080),
      // todo: slow effect + size
   );

  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
