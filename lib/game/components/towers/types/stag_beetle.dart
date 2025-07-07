import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/palla_di_fango_abilita.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/spostamento_rapido_abilita.dart';
import 'package:microworld_td/game/components/bullet/types/mud_bullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class StagBeetleTower extends BaseTower 
{
  StagBeetleTower()
      : super(
          towerName: "Stag Beetle",
          cost: 200,
          sellCost: 100,
          upgradeCost: [60,70,90,100,150],
          fireRate: 1.5,
          towerLevel: 1,
          antKilled: 0,
          range: 100,
          damage: 120,
          sprite_path: 'sprites/cervo_volante.webp',
          sprite_icon_path: 'images/UI/tower_icons/cervo_volante_i.webp',
          sprite_size: Vector2(120, 120),
          nome_abl_sx: "Palla di Fango",
          nome_abl_dx: "Cambio Rapido",
          sprite_abl_dx_path: "images/UI/ability_icons/spostamento_rapido_i.webp",
          sprite_abl_sx_path: "images/UI/ability_icons/palla_di_fango_i.webp",
          cost_abl_sx: 1,
          cost_abl_dx: 100,

        ){
          size = Vector2(80, 80);
        }

  @override
  void attackTarget(BaseEnemy target) {
    parent?.add(MudBullet(tower: this, target: target, damage: damage));
  }
  
  @override
  void implementUpgrade(int side, BaseTower tower) { 
  {
    switch(side)
    {
      case 0: 
      {
        var abilita = PallaDiFangoAbilita(tower: tower, ability_name: nome_abl_sx);
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
}
