import 'dart:async';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/levels/level.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/systems/level_manager.dart';


class GamePlay extends PositionComponent with HasGameReference<MicroworldGame>
{
  late TiledComponent tiles;
  late EnemySpawner enemySpawner;
  late final CameraComponent cam;
  
  BaseTower? towerBeingPlaced;

  late List<BaseTower> towersPlaced;

  bool isPlacingTower = false;
  bool isSelectingTower = false;
  bool waveOnGoing = false;

  late List<Vector2> waypoints;

  @override
  FutureOr<void> onLoad() async
  {
    Level currentlevel = LevelManager.getLevel(LevelManager.current_level);
    tiles = await TiledComponent.load(currentlevel.level_tile_name, Vector2.all(32)); //farlo diventare dinamico
    waypoints = currentlevel.path;

    final world = World();
    
    await add(world);
    await add(tiles);

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

}
