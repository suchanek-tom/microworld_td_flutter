import 'package:microworld_td/game/components/towers/tower.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class VenomSprayerTower extends Tower {
  VenomSprayerTower({required super.position}) {
    size = Vector2(45, 45);
    fireRate = 0.8;
    range = 180;
    damage = 15;
    poisonEffect = 5; 
    towerColor = const Color.fromARGB(255, 132, 104, 3); 
  }
}
