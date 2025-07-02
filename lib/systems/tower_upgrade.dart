import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';

final class TowerUpgradeSystem 
{
  final GlobalKey<TowerPanelUpgradeComponentState> panelKey;

  late List<AbilitiesActionService> all_abilities;

  TowerUpgradeSystem({required this.panelKey});

  void openUpgradePanel(BaseTower towerToUpgrade) 
  {
    panelKey.currentState?.showForTower(towerToUpgrade);
  }

  void closeUpgradePanel() {
    panelKey.currentState?.hide();
  }

  // Esempio: upgrade della torre (da completare)
  static BaseTower levelUp(BaseTower towerToUpgrade, int coins) 
  {
    towerToUpgrade.towerLevel ++;
    print(towerToUpgrade.towerLevel);

    switch (towerToUpgrade.towerLevel)
    {
      case 2: 
        {
          towerToUpgrade.damage += 5;
          break;
        }
      case 3:
        {
          towerToUpgrade.fireRate -= towerToUpgrade.fireRate * 20 / 100;
          towerToUpgrade.damage + 15;
          break;
        }
      case 4:
        {
          towerToUpgrade.range += 20;
          towerToUpgrade.damage += 15;
          break;
        }
      case 5:
        {
          towerToUpgrade.fireRate -= towerToUpgrade.fireRate * 20 / 100;
          towerToUpgrade.damage += 25;
          print(towerToUpgrade.fireRate);
          break;
        }
    }
    return towerToUpgrade;
  }

  static BaseTower abilityUpgrade(BaseTower towerToUpgrade, int coins, int side) 
  {
    towerToUpgrade.implementUpgrade(side);
    // Implementa la logica di upgrade per le abilità...
    return towerToUpgrade;
  }
}
