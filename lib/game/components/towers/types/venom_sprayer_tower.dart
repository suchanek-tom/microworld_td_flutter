import 'package:microworld_td/game/components/towers/tower.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class VenomSprayerTower extends Tower {
  VenomSprayerTower({required Vector2 position}) : super(position: position) {
    size = Vector2(45, 45);
    fireRate = 0.8;
    range = 180;
    damage = 15;
    poisonEffect = 5; // 5 dmg za sekundu po určitou dobu
    towerColor = const Color(0xFF008080); // Tyrkysová
  }
}
