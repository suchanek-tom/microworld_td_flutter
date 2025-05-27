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

  @override
  void initState() 
  {
   super.initState();
   maingame = MicroworldGame();
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
              'TowerPanel': (context, game) => GameOverlayUI(game: maingame, overlayName: 'TowerPanel'),
              'TowerPanelUpgrade': (context, game) => GameOverlayUI(game: maingame, overlayName: 'TowerPanelUpgrade'),
            },
          )
      ),
      ),
    );
  }
}