import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/miele_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/pungiglione_avvelenato_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BeeTower extends BaseTower {
  BeeTower()
      : super(
          towerName: "Bee",
          fireRate: 0.3,
          cost: 100,
          antKilled: 0,
          sellCost: 40,
          upgradeCost: 30,
          towerLevel: 1,
          range: 200,
          damage: 5,
          sprite_path: 'sprites/bee.png',
          sprit_icon_path: 'images/UI/tower_icons/bee_i.png',
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
  void implementUpgrade(int side)
  {
     switch(side)
    {
      case 0: 
      {
        left_abilities.add(MieleAbilita());
        break;
      }

      case 1: 
      {
        right_abilities.add(PungiglioneAvvelenatoAbilita());
      }

      default: "error, can't upgrade tower $towerName";
    }
  }
}
