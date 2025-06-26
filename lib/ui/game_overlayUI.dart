import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/select_menu/pause_menu.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';
import 'tower_panel_component.dart';

 class GameOverlayUI 
{
  GameOverlayUI({required this.game,});

  final MicroworldGame game;
  final Map<String, Widget> overlayInstances = {};
  final GlobalKey<TowerPanelUpgradeComponentState> upgrade_panel_Key = GlobalKey<TowerPanelUpgradeComponentState>();
  final GlobalKey<TowerPanelComponentState> tower_panel_Key = GlobalKey<TowerPanelComponentState>();   

  Widget buildPanels(String overlayName)
  {
    switch (overlayName) 
    {
      case 'TowerPanel':
      {
        overlayInstances["TowerPanel"] = TowerPanelComponent(key: tower_panel_Key, gamePlay: game.gamePlay);
        sendPanelOverlays("TowerPanel",tower_panel_Key);
        return overlayInstances["TowerPanel"]!;
      }
      case 'TowerPanelUpgrade':
      {
        overlayInstances["TowerPanelUpgrade"] = TowerPanelUpgradeComponent(key: upgrade_panel_Key, game: game.gamePlay);
        sendPanelOverlays("TowerPanelUpgrade",upgrade_panel_Key);
        return overlayInstances["TowerPanelUpgrade"]!;
      }
      case 'PauseMenuPanel':
      {
        overlayInstances["PauseMenuPanel"] = PauseMenu(game: game);
        game.overlayInstances[overlayName] = overlayInstances[overlayName]!;
        return overlayInstances["PauseMenuPanel"]!;
      }
      default:
      return const SizedBox.shrink(); // Nessun overlay trovato
    }
  }

  void sendPanelOverlays(String overlayName, GlobalKey key) 
  {
  game.overlayInstances[overlayName] = overlayInstances[overlayName]!;

  switch (overlayName) {
    case "TowerPanelUpgrade":
      game.upgradepanelKeystate = key as GlobalKey<TowerPanelUpgradeComponentState>;
      break;

    case "TowerPanel":
      game.towerpanelKeystate = key as GlobalKey<TowerPanelComponentState>;
      break;
  }
}
}
