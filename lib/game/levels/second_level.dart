import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/camo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
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

  static Map<int, List<Map<String, dynamic>>> waveConfigLevel2 = {
  1:  [{'type': WorkerAnt, 'count': 20}],
  2:  [{'type': WorkerAnt, 'count': 25}, {'type': TurboAnt, 'count': 10}],
  3:  [{'type': TurboAnt, 'count': 25}],
  4:  [{'type': WorkerAnt, 'count': 25}, {'type': ArmoredAnt, 'count': 5}],
  5:  [{'type': CamoAnt, 'count': 5}],
  6:  [{'type': WorkerAnt, 'count': 20}, {'type': TurboAnt, 'count': 15}, {'type': ArmoredAnt, 'count': 10}],
  7:  [{'type': TurboAnt, 'count': 8}, {'type': CamoAnt, 'count': 10}],
  8:  [{'type': ArmoredAnt, 'count': 15}],
  9:  [{'type': CamoAnt, 'count': 6}, {'type': QueenGuard, 'count': 4}],
  10: [{'type': QueenGuard, 'count': 6}, {'type': ArmoredAnt, 'count': 15}],
  11: [{'type': QueenGuard, 'count': 10},{'type': QueenAnt, 'count': 1},{'type': QueenGuard, 'count': 6}],
  };

  SecondLevel()
   : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName,
      waveConfiglevel: waveConfigLevel2,
  );

}