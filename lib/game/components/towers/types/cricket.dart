import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/canto_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/danno_ad_aria_abilita.dart';
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
        fireRate: 10,
        upgradeCost: 30,
        towerLevel: 1,
        antKilled: 0,
        range: 300,
        damage: 90,
        sprite_path: 'sprites/grillo.png',
        sprit_icon_path: 'images/UI/tower_icons/grillo_i.png',
        sprite_size: Vector2(90, 90),
      ){
        size = Vector2(45, 45);
      }

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
  int sellTower(BaseTower towerToSell) {
    // TODO: implement sellTower
    throw UnimplementedError();
  }
  
  @override
  void implementUpgrade(int side) {
     switch(side)
    {
      case 0: 
      {
        left_abilities.add(CantoAbilita());
        break;
      }

      case 1: 
      {
        right_abilities.add(DannoAdAriaAbilita());
      }

      default: "error, can't upgrade tower $towerName";
    }
  }
}
