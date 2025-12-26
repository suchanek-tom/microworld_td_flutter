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
  static List<Vector2> levelTwo_waypoints = 
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
      path: levelTwo_waypoints,
      level_tile_name: levelTileName,
      waveConfiglevel:{
      1: [{'type': WorkerAnt, 'count': 8}, {'type': ArmoredAnt, 'count': 2}],
      2: [{'type': WorkerAnt, 'count': 6}, {'type': ArmoredAnt, 'count': 4}, {'type': TurboAnt, 'count': 2}, {'type': WorkerAnt, 'count': 4}],
      3: [{'type': WorkerAnt, 'count': 10}, {'type': ArmoredAnt, 'count': 6}, {'type': TurboAnt, 'count': 10}],
      4: [{'type': CamoAnt, 'count': 10}],
      5: [{'type': WorkerAnt, 'count': 15}, {'type': ArmoredAnt, 'count': 15}],
      6: [{'type': QueenGuard, 'count': 5},{'type': QueenAnt, 'count': 1},{'type': QueenGuard, 'count': 5}],
      7: [{'type': WorkerAnt, 'count': 5}, {'type': TurboAnt, 'count': 2}, {'type': ArmoredAnt, 'count': 10}, {'type': TurboAnt, 'count': 30}],
      8: [{'type': ArmoredAnt, 'count': 30},{'type': ArmoredAnt, 'count': 10},{'type': CamoAnt, 'count': 10}],
      9: [{'type': CamoAnt, 'count': 10},{'type': CamoAnt, 'count': 10},{'type': TurboAnt, 'count': 10},{'type': CamoAnt, 'count': 10}],
      10: [{'type': ArmoredAnt, 'count': 20},{'type': ArmoredAnt, 'count': 10},{'type': CamoAnt, 'count': 10}],
      11: [{'type': WorkerAnt, 'count': 30}, {'type': TurboAnt, 'count': 20},{'type': CamoAnt, 'count': 15}],
      12: [{'type': QueenGuard, 'count': 10}, {'type': ArmoredAnt, 'count': 5}, {'type': QueenAnt, 'count': 1},{'type': QueenGuard, 'count': 10}, {'type': ArmoredAnt, 'count': 10}, {'type': QueenAnt, 'count': 1}],
    },
  );

}