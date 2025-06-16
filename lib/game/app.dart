import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/game_overlayUI.dart';

class GameApp extends StatefulWidget 
{
  final MicroworldGame maingame;
  const GameApp(this.maingame, {super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final GameOverlayUI gameOverlays;

  @override
  void initState() {
    super.initState();
    gameOverlays = GameOverlayUI(game: widget.maingame); // <-- qui era l'errore
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GameWidget(
            game: widget.maingame,  // <-- qui uguale
            overlayBuilderMap: {
              'TowerPanel': (context, game) => gameOverlays.buildPanels("TowerPanel"),
              'TowerPanelUpgrade': (context, game) => gameOverlays.buildPanels("TowerPanelUpgrade"),
            },
          ),
        ),
      ),
    );
  }
}
