import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/spostamento_rapido_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/tela_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/standard_bullet.dart';
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
    parent?.add(StandardBullet(tower: this, target: target, damage: damage));
  }
  
  @override
  int sellTower(BaseTower towerToSell) {
    // TODO: implement sellTower
    throw UnimplementedError();
  }
  
  @override
  void implementUpgrade(int side, BaseTower tower) {
    switch(side)
    {
      case 0: 
      {
        print("pronti tela");
        var abilita = TelaAbilita(tower: tower);
        left_abilities.add(abilita);
        parent!.add(abilita);
        break;
      }

      case 1: 
      {
        right_abilities.add(SpostamentoRapidoAbilita());
      }

      default: "error, can't upgrade tower $towerName";
    }
  }

}
