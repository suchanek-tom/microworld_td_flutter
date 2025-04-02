import 'dart:ui';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:flame/components.dart';

class VenomSprayerTower extends BaseTower {
  VenomSprayerTower({required Vector2 position})
    : super (
      position: position,
      fireRate: 0.8,
      range: 180,
      damage: 15,
      towerColor: const Color.fromARGB(255, 132, 104, 3)
      // todo: size + Vector2(45, 45);
      // todo: poisonEffect = 5
    );

  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
}
