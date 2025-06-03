import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/game_overlayUI.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> 
{
  late final MicroworldGame maingame;
  late final GameOverlayUI gameOverlays;

  @override
  void initState() 
  {
   super.initState();
   maingame = MicroworldGame();
   gameOverlays = GameOverlayUI(game: maingame);
  }

  @override
  Widget build(BuildContext context)
   {
    
    return ClipRect(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GameWidget
          (
            game: maingame,overlayBuilderMap: 
            {
              'TowerPanel': (context, game) => gameOverlays.buildPanels("TowerPanel"),
              'TowerPanelUpgrade': (context, game) => gameOverlays.buildPanels("TowerPanelUpgrade"),
            },
          )
        ),
      ),
    );
  }
}