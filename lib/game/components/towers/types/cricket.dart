import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class Cricket extends BaseTower 
{
    Cricket()
    : super(
        towerName: "Cricket",
        cost: 120,
        sellCost: 50,
        fireRate: 2,
        range: 100,
        damage: 150,
        sprite_path: 'sprites/grillo.png',
        sprit_icon_path: 'images/UI/tower_icons/grillo_i.png',
        sprite_size: Vector2(110, 110),
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
