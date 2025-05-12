
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queens_guard.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';

class EnemySpawner extends Component {
  final List<Vector2> waypoints;
  final double spawnInterval;
  double timer = 0;
  int enemiesToSpawn = 0;
  int enemiesRemaining = 0;
 
  EnemySpawner({required this.waypoints, this.spawnInterval = 2.0});

  final Map<int, List<Map<String, dynamic>>> waveConfig = {
  1: [{'type': WorkerAnt, 'count': 5}],
  2: [{'type': WorkerAnt, 'count': 8}],
  3: [{'type': WorkerAnt, 'count': 6}, {'type': TurboAnt, 'count': 2}],
  4: [{'type': TurboAnt, 'count': 5}],
  5: [{'type': WorkerAnt, 'count': 5}, {'type': ArmoredAnt, 'count': 2}],
  6: [{'type': TurboAnt, 'count': 6}, {'type': ArmoredAnt, 'count': 2}],
  7: [{'type': WorkerAnt, 'count': 4}, {'type': TurboAnt, 'count': 4}, {'type': ArmoredAnt, 'count': 3}],
  8: [{'type': ArmoredAnt, 'count': 5}],
  9: [{'type': WorkerAnt, 'count': 6}, {'type': TurboAnt, 'count': 6}],
  10: [{'type': QueensGuard, 'count': 1}, {'type': ArmoredAnt, 'count': 3}],
};


  @override
  void update(double dt) 
  {
    super.update(dt);

    if (enemiesToSpawn <= 0 && enemiesRemaining == 0) {
      if (GameState.waveNumber >= 10) {
        GameState.winGame();
        return;
      }

      GameState.waveNumber++;
      startNewWave();
    }

    timer += dt;
    if (timer >= spawnInterval && enemiesToSpawn > 0) {
      timer = 0;
      spawnNextEnemy();
    }
  }

  void startNewWave() {
    enemiesToSpawn = 0;

    if (waveConfig.containsKey(GameState.waveNumber)) {
      for (var enemyGroup in waveConfig[GameState.waveNumber]!) {
        enemiesToSpawn += enemyGroup['count'] as int;
      }
    } else {
      enemiesToSpawn = 5 + (GameState.waveNumber * 2); 
    }
  }

  void spawnNextEnemy() {
    final List<Map<String, dynamic>>? currentWave = waveConfig[GameState.waveNumber];

    if (currentWave != null) {
      for (var enemyGroup in currentWave) {
        if ((enemyGroup['count'] as int) > 0) {
          spawnEnemy(enemyGroup['type']);
          enemyGroup['count'] = (enemyGroup['count'] as int) - 1;
          enemiesToSpawn--;
          enemiesRemaining++;
          return;
        }
      }
    }
  }

  void spawnEnemy(Type enemyType) {
    late BaseEnemy enemy;

    if (enemyType == WorkerAnt) {
      enemy = WorkerAnt(waypoints: waypoints);
    } else if (enemyType == ArmoredAnt) {
      enemy = ArmoredAnt(waypoints: waypoints);
    } else if (enemyType == TurboAnt) {
      enemy = TurboAnt(waypoints: waypoints);
    } else if (enemyType == QueensGuard) {
      enemy = QueensGuard(waypoints: waypoints);
    }

    enemy.onDeath = () {
      enemiesRemaining--;
    };
  }
}
