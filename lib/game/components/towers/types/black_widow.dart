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
          range: 150,
          sellCost: 75,
          damage: 20,
          sprite_path: 'sprites/vedova_nera.webp',
          sprite_icon_path: 'images/UI/tower_icons/vedova_nera_i.webp',
          sprite_size: Vector2(90, 90),
          nome_abl_sx: "Tela",
          nome_abl_dx: "cambio rapido",
          sprite_abl_dx_path: "images/UI/ability_icons/spostamento_rapido_i.webp",
          sprite_abl_sx_path: "images/UI/ability_icons/web_i.webp",
          cost_abl_sx: 110,
          cost_abl_dx: 100,
        ){
          size = Vector2(50, 50);
        }

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(StandardBullet(tower: this, target: target, damage: damage));
  }
    
  @override
  void implementUpgrade(int side, BaseTower tower) {
    switch(side)
    {
      case 0: 
      {
        var abilita = TelaAbilita(tower: tower, ability_name: nome_abl_sx);
        hasLeft_ability = true;
        parent!.add(abilita);
        break;
      }

      case 1: 
      {
        //right_abilities.add(SpostamentoRapidoAbilita());
      }

      default: "error, can't upgrade tower $towerName";
    }
  }

}
