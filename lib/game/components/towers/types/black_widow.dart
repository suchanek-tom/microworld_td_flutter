import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/inseguimento_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/tela_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/standartBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class BlackWidowTower extends BaseTower {
  BlackWidowTower()
      : super(
          towerName: "Black Widow",
          cost: 175,
          antKilled: 0,
          fireRate: 0.5,
          upgradeCost: [50,70,80,100,120],
          towerLevel: 1,
          range: 300,
          sellCost: 75,
          damage: 10,
          sprite_path: 'sprites/vedova_nera.webp',
          sprit_icon_path: 'images/UI/tower_icons/vedova_nera_i.webp',
          sprite_size: Vector2(90, 90),
        ){
          size = Vector2(35, 35);
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
        left_abilities.add(TelaAbilita());
        break;
      }

      case 1: 
      {
        right_abilities.add(InseguimentoAbilita());
      }

      default: "error, can't upgrade tower $towerName";
    }
  }

}
