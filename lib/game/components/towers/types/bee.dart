import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BeeTower extends BaseTower {
  BeeTower()
      : super(
          towerName: "Bee",
          fireRate: 0.3,
          cost: 100,
          sellCost: 40,
          range: 200,
          damage: 5,
          sprite_path: 'sprites/bee.png',
          sprit_icon_path: 'sprites/tower_icons/bee_i.png',
          sprite_size: Vector2(90, 90),
        );

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(position: position.clone(), target: target, damage: damage));
  }
  
  @override
  Target changeTarget() {
    // TODO: implement changeTarget
    throw UnimplementedError();
  }
  
  @override
  int killCounter() {
    // TODO: implement killCounter
    throw UnimplementedError();
  }
  
  @override
  int sellTower(BaseTower towerToSell) {
    // TODO: implement sellTower
    throw UnimplementedError();
  }
}
