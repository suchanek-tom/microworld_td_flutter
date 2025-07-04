import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/miele_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/pungiglione_avvelenato_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/standard_bullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BeeTower extends BaseTower {
  BeeTower()
      : super(
          towerName: "Bee",
          fireRate: 0.8,
          cost: 100,
          antKilled: 0,
          sellCost: 40,
          upgradeCost: [30,50,60,70,110],
          towerLevel: 1,
          range: 200,
          damage: 10,
          sprite_path: 'sprites/bee.webp',
          sprit_icon_path: 'images/UI/tower_icons/bee_i.webp',
          sprite_size: Vector2(90, 90),
        ){
          size = Vector2(45, 45);
        }

  @override
  void attackTarget(BaseEnemy target) {
   parent?.add(StandardBullet(tower: this, target: target, damage: damage));
  }
  
  
  @override
  int sellTower(BaseTower towerToSell) {
    // TODO: implement sellTower
    throw UnimplementedError();
  }
  
  @override
  void implementUpgrade(int side, BaseTower tower) {
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
        print("pronti veleno");
        var abilita = PungiglioneAvvelenatoAbilita(tower: tower);
        right_abilities.add(abilita);
        parent!.add(abilita);
        break;
      }

      default: "error, can't upgrade tower $towerName";
    }
  }
  }
}
