import 'dart:async';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';
import 'package:microworld_td/game/components/towers/types/sniper_ant_tower.dart';

class GamePlay extends Component {

  late TiledComponent level;
  late EnemySpawner enemySpawner;
  late final CameraComponent cam;

  @override
  FutureOr<void> onLoad() async
  {
    level = await TiledComponent.load("level1.tmx", Vector2.all(64));
    final world = World(children: [level]);
    
    await add(world);
    cam = CameraComponent.withFixedResolution(world: world, width: 1280, height: 768);
    cam.viewfinder.anchor = Anchor.topLeft;

    //wayponts for the level 1 that neads to be moved
    List<Vector2> waypoints = [
      Vector2(130, 0), 
      Vector2(130, 190),
      Vector2(510, 190),
      Vector2(510, 320),
      Vector2(130, 320),
      Vector2(130, 580),
      Vector2(510, 580),
      Vector2(510, 700),
      Vector2(830, 700),
      Vector2(830, 130),
      Vector2(1020, 130),
      Vector2(1030, 710),
      Vector2(1290, 710),
    ];
    add(PathComponent(waypoints: waypoints));

    // Nepřátelé
    enemySpawner = EnemySpawner(
      waypoints: waypoints,
      spawnInterval: 2,
    );
    add(enemySpawner);
    

    // Ukázkové věže
    //add(SniperAntTower(position: Vector2(300, 250)));
    //add(BeeTower(position: Vector2(250, 350)));

    return super.onLoad();
  }
}
