import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/camo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
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

static Map<int, List<Map<String, dynamic>>> waveConfigLevel3 = {
  1:  [{'type': WorkerAnt, 'count': 15}],
  2:  [{'type': TurboAnt, 'count': 15}],
  3:  [{'type': WorkerAnt, 'count': 10}, {'type': TurboAnt, 'count': 10}],
  4:  [{'type': ArmoredAnt, 'count': 10}],
  5:  [{'type': CamoAnt, 'count': 12}, {'type': TurboAnt, 'count': 8}],
  6:  [{'type': ArmoredAnt, 'count': 10}, {'type': WorkerAnt, 'count': 10}],
  7:  [{'type': CamoAnt, 'count': 15}, {'type': TurboAnt, 'count': 10}],
  8:  [{'type': QueenGuard, 'count': 15}],
  9:  [{'type': CamoAnt, 'count': 12}, {'type': ArmoredAnt, 'count': 12}],
  10: [{'type': TurboAnt, 'count': 20}, {'type': QueenGuard, 'count': 10}],
  11: [{'type': QueenGuard, 'count': 15}, {'type': CamoAnt, 'count': 10}],
  12: [{'type': ArmoredAnt, 'count': 15}, {'type': TurboAnt, 'count': 15}],
  13: [{'type': QueenGuard, 'count': 10}, {'type': QueenAnt, 'count': 2}],
  14: [{'type': CamoAnt, 'count': 20}, {'type': ArmoredAnt, 'count': 10}],
  15: [{'type': QueenAnt, 'count': 3},{'type': CamoAnt, 'count': 20}, {'type': ArmoredAnt, 'count': 10},{'type': QueenGuard, 'count': 10}],
};

  ThirdLevel()
   : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName,
      waveConfiglevel: waveConfigLevel3,
  );  
}