import 'package:flame/components.dart';
import 'package:microworld_td/game/levels/level.dart';
class FirstLevel extends Level
{
  static String levelTileName = "level1.tmx";
  static List<Vector2> levelOne_waypoints = 
  [ 
    Vector2(65, 0), Vector2(67, 95),
    Vector2(255, 95),Vector2(255, 160),
    Vector2(65, 160),Vector2(65, 290),
    Vector2(255, 290),Vector2(255, 350),
    Vector2(415, 350),Vector2(415, 65),
    Vector2(515, 65),Vector2(515, 350),
    Vector2(800, 350),
  ];

  FirstLevel()
    : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName 
    );
}