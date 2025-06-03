import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';
import 'tower_panel_component.dart';

 class GameOverlayUI 
{
  GameOverlayUI({required this.game,});

  final MicroworldGame game;
  final Map<String, Widget> overlayInstances = {};
  final GlobalKey<TowerPanelUpgradeComponentState> upgradepanelKey = GlobalKey<TowerPanelUpgradeComponentState>();
  final GlobalKey<TowerPanelComponentState> towerpanelKey = GlobalKey<TowerPanelComponentState>();
   

  Widget buildPanels(String overlayName)
  {
    switch (overlayName) 
    {
      case 'TowerPanel':
      {
        overlayInstances["TowerPanel"] = TowerPanelComponent(key: towerpanelKey, game: game.gamePlay);
        sendPanelOverlays("TowerPanel",towerpanelKey);
        return overlayInstances["TowerPanel"]!;
      }
      case 'TowerPanelUpgrade':
      {
        overlayInstances["TowerPanelUpgrade"] = TowerPanelUpgradeComponent(key: upgradepanelKey, game: game.gamePlay);
        sendPanelOverlays("TowerPanelUpgrade",upgradepanelKey);
        return overlayInstances["TowerPanelUpgrade"]!;
      }
      default:
      return const SizedBox.shrink(); // Nessun overlay trovato
    }
  }

  void sendPanelOverlays(String overlayName, GlobalKey key)
  {
    game.overlayInstances[overlayName] = overlayInstances[overlayName]!;
    if(overlayName == "TowerPanelUpgrade") {
      game.upgradepanelKeystate = key as  GlobalKey<TowerPanelUpgradeComponentState>;
    }else{
      game.towerpanelKeystate = key as GlobalKey<TowerPanelComponentState>;
    }
  }
}
