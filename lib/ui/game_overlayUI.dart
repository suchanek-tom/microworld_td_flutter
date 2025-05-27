import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';
import 'tower_panel_component.dart';

 class GameOverlayUI extends StatelessWidget
{

  const GameOverlayUI({super.key,required this.game,required this.overlayName,});
 
  final MicroworldGame game;
  final String overlayName;
 
  @override
  Widget build(BuildContext context) 
  {

     switch (overlayName) 
     {
      case 'TowerPanel':
        return TowerPanelComponent(game: game.gamePlay);
      case 'TowerPanelUpgrade':
        return TowerPanelUpgradeComponent(game: game.gamePlay);
      default:
        return const SizedBox.shrink(); // Nessun overlay trovato
    }
  }
}