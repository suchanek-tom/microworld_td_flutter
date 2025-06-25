import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/microworld_game.dart';


class GamePlay extends PositionComponent with HasGameReference<MicroworldGame>
{
  late TiledComponent level;
  late EnemySpawner enemySpawner;
  late final CameraComponent cam;
  
  BaseTower? towerBeingPlaced;

  late List<BaseTower> towersPlaced;

  bool isPlacingTower = false;
  bool isSelectingTower = false;
  bool waveOnGoing = false;

  List<Vector2> waypoints = [ //da spostare in seguito
    Vector2(65, 0), 
    Vector2(67, 95),
    Vector2(255, 95),
    Vector2(255, 160),
    Vector2(65, 160),
    Vector2(65, 290),
    Vector2(255, 290),
    Vector2(255, 350),
    Vector2(415, 350),
    Vector2(415, 65),
    Vector2(515, 65),
    Vector2(515, 350),
    Vector2(800, 350),
  ];
  
  @override
  FutureOr<void> onLoad() async
  {
    level = await TiledComponent.load("level1.tmx", Vector2.all(32)); //farlo diventare dinamico
    final world = World();
    
    await add(world);
    await add(level);

    final aspect_ratio = MediaQuery.of(game.buildContext!).size.aspectRatio;
    const height = 200.0;
    final width = height * aspect_ratio;

    cam = CameraComponent.withFixedResolution(world: world, width: width, height: height);
    cam.viewfinder.anchor = Anchor.topLeft;
  
    game.initializeUpgradeSystem();
    add(PathComponent(waypoints: waypoints));
    add(EnemySpawner(waypoints: waypoints,spawnInterval: 3.25,game: this,));

    return super.onLoad();
  }

  void placingTower(BaseTower tower)
  {
    towerBeingPlaced = tower;
    towerBeingPlaced!.inplacement = true;
    isPlacingTower = true;
  }

  //i think this neads to be on microworldgame
  void pauseGame() {
  FlameGame? parentGame = findParent<FlameGame>();
  if (parentGame != null) {
    parentGame.pauseEngine();
    parentGame.overlays.add('PauseMenu');
  }
  }

  void startGame() 
  {
    if(waveOnGoing != true)
    {
      waveOnGoing = true;
      GameState.nextWave();
      EnemySpawner.startNewWave(); 
    }
  }
}
