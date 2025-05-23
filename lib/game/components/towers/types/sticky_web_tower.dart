import 'package:microworld_td/game/components/towers/tower.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class StickyWebTower extends Tower {
  StickyWebTower({required super.position}) {
    size = Vector2(40, 40);
    fireRate = 1.0;
    range = 100;
    damage = 5;
    slowEffect = 0.5; 
    towerColor = const Color(0xFF800080); 
  }
}
