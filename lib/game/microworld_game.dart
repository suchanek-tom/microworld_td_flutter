import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:microworld_td/game/components/towers/tower.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';


class MicroworldGame extends FlameGame {
  List<Vector2> waypoints = [
    Vector2(50, 550),
    Vector2(50, 400),
    Vector2(200, 400),
    Vector2(200, 250),
    Vector2(400, 250),
    Vector2(400, 450),
    Vector2(600, 450),
    Vector2(600, 300),
    Vector2(750, 300)  
  ];

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF87CEEB),
    ));

    
    add(Tower(position: Vector2(250, 350)));
    add(Tower(position: Vector2(250, 400)));

    add(EnemySpawner(waypoints: waypoints, spawnInterval: 5.0, enemiesToSpawn: 6));

    debugPrint("Microworld TD Game Loaded!");
  }
}
