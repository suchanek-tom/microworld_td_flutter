import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/game_overlayUI.dart';

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
            },
          ),
        ),
      ),
    );
  }
}
