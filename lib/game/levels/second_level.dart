import 'package:flame/components.dart';
import 'package:microworld_td/game/levels/level.dart';

class SecondLevel extends Level
{

   static String levelTileName = "level2.tmx";
  static List<Vector2> levelOne_waypoints = 
  [ 
    Vector2(0, 97), 
    Vector2(225, 97),
    Vector2(225, 320),
    Vector2(130, 320),
    Vector2(130, 190),
    Vector2(355, 190),
    Vector2(355, 65),
    Vector2(515, 65),
    Vector2(515, 288),
    Vector2(738, 288),
    Vector2(738, 160),
    Vector2(610, 160),
    Vector2(610, 416),
  ];

  SecondLevel()
   : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName 
  );

}