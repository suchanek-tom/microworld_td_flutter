import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/canto_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/danno_ad_area_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/sonar_bullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class CricketTower extends BaseTower 
{
    CricketTower()
    : super(
        towerName: "Cricket",
        cost: 120,
        sellCost: 50,
        fireRate: 1,
        upgradeCost: [30,50,80,90,110],
        towerLevel: 1,
        antKilled: 0,
        range: 100,
        damage: 30,
        cost_abl_dx: 1,
        cost_abl_sx: 70,
        sprite_path: 'sprites/grillo.webp',
        sprite_icon_path: 'images/UI/tower_icons/grillo_i.webp',
        sprite_size: Vector2(90, 90),
        nome_abl_sx: "Canto del Grillo",
        nome_abl_dx: "Danno ad Area",
        sprite_abl_dx_path: "images/UI/ability_icons/danno_ad_area.webp",
        sprite_abl_sx_path: "images/UI/ability_icons/canto_del_grillo.webp"
      ){
        size = Vector2(55, 55);
      }

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(SonarBullet(tower: this, target: target, damage: damage));
  }
  
  @override
  void implementUpgrade(int side, BaseTower tower) {
     switch(side)
    {
      case 0: 
      {
        var abilita = CantoAbilita(tower: tower, ability_name: nome_abl_sx);
        hasLeft_ability = true;
        parent!.add(abilita);
        break;
      }

      case 1: 
      {
        var abilita =  DannoAdAreaAbilita(tower: tower,ability_name: nome_abl_dx);
        hasRight_ability = true;
        parent!.add(abilita);
        break;
      }

      default: "error, can't upgrade tower $towerName";
    }
  }
}
