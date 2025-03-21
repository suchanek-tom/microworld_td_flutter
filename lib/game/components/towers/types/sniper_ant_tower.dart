import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/towers/tower.dart';

class SniperAntTower extends Tower {
  SniperAntTower({required Vector2 position}) : super(position: position) {
    size = Vector2(50, 50);
    fireRate = 2.5;
    range = 300;
    damage = 50;
    towerColor = const Color(0xFF006400); // Tmavě zelená
  }
}
