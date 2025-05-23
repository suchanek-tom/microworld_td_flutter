import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'towerPanelComponent.dart';

 class Gameoverlayui extends StatelessWidget
{
  const Gameoverlayui({super.key, required this.game});

  final MicroworldGame game;


  @override
  Widget build(BuildContext context) 
  {
    //calling the towerpannel
    return  TowerPanelComponent(game: game.gamePlay,);
  }
  
}