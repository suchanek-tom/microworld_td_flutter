import 'package:microworld_td/menu/select_menu/game_over_menu.dart';
import 'package:microworld_td/menu/select_menu/game_win_menu.dart';
import 'package:microworld_td/ui/game_overlayUI.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late MicroworldGame _game;

  @override
  void initState() {
    super.initState();
    _game = MicroworldGame();
  }

  @override
  void dispose() {
    _game.pauseEngine(); // Assicurati che il motore sia in pausa prima del dispose
    // È una buona pratica chiamare anche il dispose del gioco se ha risorse da liberare
    _game.onRemove(); // Chiama onRemove per pulire i componenti del gioco
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameOverlays = GameOverlayUI(game: _game);

    return ClipRect(
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GameWidget(
            game: _game, 
            overlayBuilderMap: {
              'TowerPanel': (context, game) => gameOverlays.buildPanels("TowerPanel"),
              'TowerPanelUpgrade': (context, game) => gameOverlays.buildPanels("TowerPanelUpgrade"),
              'PauseMenuPanel': (context, game) => gameOverlays.buildPanels('PauseMenuPanel'),
              'GameOverMenu': (context, game) => GameOverMenu(game: game as MicroworldGame),
              'GameWinMenu': (context, game) => GameWinMenu(game: game as MicroworldGame),
            },
          ),
        ),
      ),
    );
  }
}
