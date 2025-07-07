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
          sprite_icon_path: 'images/UI/tower_icons/bee_i.webp',
          sprite_size: Vector2(90, 90),
          nome_abl_dx: "veleno",
          nome_abl_sx: "Miele",
          sprite_abl_dx_path: "images/UI/ability_icons/pungiglione_avvelenato_i.webp",
          sprite_abl_sx_path: "images/UI/ability_icons/miele_i.webp",
          cost_abl_sx: 1,
          cost_abl_dx: 90,
          
        ){
          size = Vector2(60, 60);
        }

  @override
  void attackTarget(BaseEnemy target) {
   parent?.add(StandardBullet(tower: this, target: target, damage: damage));
  }
  
  @override
  void implementUpgrade(int side, BaseTower tower) {
  {
     switch(side)
    {
      case 0: 
      {
        print("pronti miele");
        var abilita = MieleAbilita(tower: tower, ability_name: nome_abl_sx);
        hasLeft_ability = true;
        parent!.add(abilita);
        break;
      }

      case 1: 
      {
        var abilita = PungiglioneAvvelenatoAbilita(tower: tower, ability_name: nome_abl_dx);
        hasRight_ability = true;
        parent!.add(abilita);
        break;
      }

      default: "error, can't upgrade tower $towerName";
    }
  }
  }
}
