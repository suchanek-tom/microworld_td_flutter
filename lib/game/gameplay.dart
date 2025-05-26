import 'dart:async';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
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
  bool isPlacingTower = false;

  @override
  FutureOr<void> onLoad() async
  {
    level = await TiledComponent.load("level1.tmx", Vector2.all(64));
    final world = World();
    
    await add(world);
    await add(level);

    cam = CameraComponent.withFixedResolution(world: world, width: 1280, height: 768);
    cam.viewfinder.anchor = Anchor.topLeft;

    //wayponts for the level 1 that neads to be moved
    List<Vector2> waypoints = [
      Vector2(130, 0), 
      Vector2(134, 190),
      Vector2(510, 190),
      Vector2(510, 320),
      Vector2(132, 320),
      Vector2(132, 580),
      Vector2(510, 580),
      Vector2(510, 700),
      Vector2(830, 700),
      Vector2(830, 130),
      Vector2(1020, 130),
      Vector2(1030, 710),
      Vector2(1290, 710),
    ];
    add(PathComponent(waypoints: waypoints));

    // Enemy spawner
    add(EnemySpawner(waypoints: waypoints,spawnInterval: 2,game: this,));
  
    return super.onLoad();
  }

  void placingTower(BaseTower tower)
  {
    towerBeingPlaced = tower;
    towerBeingPlaced!.inplacement = true;
    isPlacingTower = true;
  }

}
