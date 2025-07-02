import 'package:flame/components.dart';
import 'package:microworld_td/game/levels/level.dart';

class ThirdLevel extends Level
{
  static String levelTileName = "level3.tmx";
  static List<Vector2> levelOne_waypoints = 
  [ 
    Vector2(33, 416), 
    Vector2(33, 30),
    Vector2(130,33),
    Vector2(130, 160),
    Vector2(255, 160),
    Vector2(255, 33),
    Vector2(385, 33),
    Vector2(385, 350),
    Vector2(255, 350),
    Vector2(255, 255),
    Vector2(735, 255),
    Vector2(735, 0),
  ];
  ThirdLevel()
   : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName 
  );  
}