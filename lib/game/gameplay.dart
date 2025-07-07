import 'dart:async';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/levels/level.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/systems/level_manager.dart';


class GamePlay extends PositionComponent with HasGameReference<MicroworldGame>
{
  late TiledComponent map;
  late EnemySpawner enemySpawner;
  late final CameraComponent cam;
  
  BaseTower? towerBeingPlaced;

  late List<BaseTower> towersPlaced;

  bool isPlacingTower = false;
  bool isSelectingTower = false;
  
  @override
  FutureOr<void> onLoad() async
  {
    print("bestia");
    Level currentlevel = LevelManager.getLevel(LevelManager.current_level);
    map = await TiledComponent.load(currentlevel.level_tile_name, Vector2.all(32)); 
    GameState.initializeGame();
  
    final world = World();
    
    await add(world);
    await add(map);

    final width = game.size.x;
    final height = game.size.y;

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: width,
      height: height,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    add(cam);
  
    add(PathComponent(waypoints: currentlevel.path));
    add(EnemySpawner(waypoints: currentlevel.path,spawnInterval: 1,game: this,waveConfig: currentlevel.waveConfiglevel));

    return super.onLoad();
  }

  void placingTower(BaseTower tower)
  {
    towerBeingPlaced = tower;
    towerBeingPlaced!.inplacement = true;
    isPlacingTower = true;
  }

}
