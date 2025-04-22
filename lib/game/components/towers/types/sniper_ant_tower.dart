import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class SniperAntTower extends BaseTower {
  SniperAntTower({required super.position}) 
      : super(
          fireRate: 0.5,
          range: 300,
          damage: 10,
          towerColor: const Color.fromARGB(255, 28, 192, 85),
        );
  
  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
 
}
