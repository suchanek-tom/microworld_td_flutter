import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'towerPanelComponent.dart';

 class Gameoverlayui extends StatelessWidget
{
  const Gameoverlayui({super.key});

  @override
  Widget build(BuildContext context) 
  {
    //calling the towerpannel
    return Opacity(
      opacity: 0.0,
      child: Scaffold(
        body: TowerPanelComponent(),
      ),
    );
  }
}