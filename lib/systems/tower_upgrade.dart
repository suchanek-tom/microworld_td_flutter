import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';

final class TowerUpgradeSystem 
{
  final GlobalKey<TowerPanelUpgradeComponentState> panelKey;

  TowerUpgradeSystem({required this.panelKey});

  void openUpgradePanel(BaseTower towerToUpgrade) 
  {
    panelKey.currentState?.showForTower(towerToUpgrade);
  }

  void closeUpgradePanel() {
    panelKey.currentState?.hide();
  }

  // Esempio: upgrade della torre (da completare)
  static BaseTower baseUpgrade(BaseTower towerToUpgrade, int coins) 
  {
    // Implementa la logica di upgrade...
    return towerToUpgrade;
  }

  static BaseTower abilityUpgrade(BaseTower towerToUpgrade, int coins) 
  {
    // Implementa la logica di upgrade per le abilità...
    return towerToUpgrade;
  }
}
