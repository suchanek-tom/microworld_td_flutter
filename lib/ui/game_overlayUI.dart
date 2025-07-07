import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/select_menu/pause_menu.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';
import 'tower_panel_component.dart';

 class GameOverlayUI 
{
  final GlobalKey<TowerPanelUpgradeComponentState> upgrade_panel_Key;
  final GlobalKey<TowerPanelComponentState> tower_panel_Key;

  GameOverlayUI({required this.game,})
  : upgrade_panel_Key = game.upgradepanelKeystate, // Usa la chiave già esistente nel game
    tower_panel_Key = game.towerpanelKeystate; 

  final MicroworldGame game;
  final Map<String, Widget> overlayInstances = {};
  
  Widget buildPanels(String overlayName)
  {
    switch (overlayName) 
    {
      case 'TowerPanel':
      {
        overlayInstances["TowerPanel"] = TowerPanelComponent(key: tower_panel_Key, gamePlay: game.gamePlay);
        return overlayInstances["TowerPanel"]!;
      }
      case 'TowerPanelUpgrade':
      {
        overlayInstances["TowerPanelUpgrade"] = TowerPanelUpgradeComponent(key: upgrade_panel_Key, game: game.gamePlay);
        return overlayInstances["TowerPanelUpgrade"]!;
      }
      case 'PauseMenuPanel':
      {
        overlayInstances["PauseMenuPanel"] = PauseMenu(game: game);
        return overlayInstances["PauseMenuPanel"]!;
      }
      default:
      return const SizedBox.shrink(); // Nessun overlay trovato
    }
  }
}
