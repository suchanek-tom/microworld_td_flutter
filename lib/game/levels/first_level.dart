import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
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

  static Map<int, List<Map<String, dynamic>>> waveConfigLevel1 = 
  {
  1: [{'type': WorkerAnt, 'count': 10}],
  2: [{'type': WorkerAnt, 'count': 10},{'type': ArmoredAnt, 'count': 4}],
  3: [{'type': WorkerAnt, 'count': 5}, {'type': ArmoredAnt, 'count': 6},{'type': TurboAnt, 'count': 5}],
  4: [{'type': TurboAnt, 'count': 10}],
  5: [{'type': WorkerAnt, 'count': 5}, {'type': ArmoredAnt, 'count': 10}],
  6: [{'type': TurboAnt, 'count': 15}, {'type': ArmoredAnt, 'count': 2}],
  7: [{'type': WorkerAnt, 'count': 10}, {'type': TurboAnt, 'count': 4}, {'type': ArmoredAnt, 'count': 10}],
  8: [{'type': ArmoredAnt, 'count': 5}],
  9: [{'type': WorkerAnt, 'count': 6}, {'type': TurboAnt, 'count': 6}],
  10: [{'type': QueenGuard, 'count': 10}, {'type': ArmoredAnt, 'count': 3},{'type': QueenAnt, 'count': 1}],
  };


  FirstLevel()
    : super(
      path: levelOne_waypoints,
      level_tile_name: levelTileName,
      waveConfiglevel: waveConfigLevel1,
    );
}