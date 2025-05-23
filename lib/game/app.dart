import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/ui/gameOverlayUI.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> 
{
  late final MicroworldGame game;

  @override
  void initState() 
  {
   super.initState();
   game = MicroworldGame();
  }

  @override
  Widget build(BuildContext context)
   {
    return ClipRect(
      child: MaterialApp(
        home: Scaffold(
          body: GameWidget(
            game: game,overlayBuilderMap: {
              "gameOverlay": (BuildContext context, MicroworldGame game){
          return Gameoverlayui(game: game,);
        }
      },)
      ),
      ),
    );
  }
}