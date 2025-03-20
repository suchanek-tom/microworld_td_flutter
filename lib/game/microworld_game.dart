import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:microworld_td/game/components/tower.dart';

class MicroworldGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));
    
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF87CEEB),
    ));

    add(Tower(position: Vector2(200, 300)));
    
    debugPrint("Microworld TD Game Loaded!");
  }
}
