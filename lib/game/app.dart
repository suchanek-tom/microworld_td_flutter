import 'package:microworld_td/menu/select_menu/game_over_menu.dart';
import 'package:microworld_td/menu/select_menu/game_win_menu.dart';
import 'package:microworld_td/ui/game_overlayUI.dart';
import 'package:microworld_td/ui/tower_panel_component.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameApp extends StatelessWidget {
  final MicroworldGame maingame;

  const GameApp(this.maingame, {super.key});

  @override
  Widget build(BuildContext context) {
    final gameOverlays = GameOverlayUI(game: maingame);

    return ClipRect(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GameWidget(
            game: maingame,
            overlayBuilderMap: {
              'TowerPanel': (context, game) => gameOverlays.buildPanels("TowerPanel"),
              'TowerPanelUpgrade': (context, game) => gameOverlays.buildPanels("TowerPanelUpgrade"),
              'PauseMenuPanel': (context, game) => gameOverlays.buildPanels('PauseMenuPanel'),
              'GameOverMenu': (context, game) => GameOverMenu(game:  game as MicroworldGame),
              'GameWinMenu': (context, game) => GameWinMenu(
                game: game as MicroworldGame,
                currentLevel: (game as MicroworldGame).currentLevel,
              ),
            },
          ),
        ),
      ),
    );
  }
}
