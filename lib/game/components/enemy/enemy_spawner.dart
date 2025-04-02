import 'dart:math';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'types/worker_ant.dart';
import 'types/armored_beetle.dart';
import 'types/fast_bug.dart';
import 'types/queens_guard.dart';

class EnemySpawner extends Component with HasGameRef {
  final List<Vector2> waypoints;
  final double spawnInterval;
  double timer = 0;
  int enemiesToSpawn;
  int enemiesRemaining = 0;
  final Random random = Random();

  EnemySpawner({
    required this.waypoints,
    this.spawnInterval = 2.0,
    this.enemiesToSpawn = 5,
  });

  @override
  void update(double dt) {
    super.update(dt);

    if (enemiesToSpawn <= 0 && enemiesRemaining == 0) {
      if (GameState.waveNumber >= 20) {
        GameState.winGame();
        return;
      }

      GameState.waveNumber++;
      enemiesToSpawn = 5 + (GameState.waveNumber * 2);
    }

    timer += dt;
    if (timer >= spawnInterval && enemiesToSpawn > 0) {
      timer = 0;
      spawnRandomEnemy();
      enemiesToSpawn--;
      enemiesRemaining++;
    }
  }

  void spawnRandomEnemy() {
    final int enemyType = random.nextInt(4);
    late BaseEnemy enemy;

    switch (enemyType) {
      case 0:
        enemy = WorkerAnt(waypoints: waypoints);
        break;
      case 1:
        enemy = ArmoredBeetle(waypoints: waypoints);
        break;
      case 2:
        enemy = FastBug(waypoints: waypoints);
        break;
      case 3:
        enemy = QueensGuard(waypoints: waypoints);
        break;
    }

  enemy.onDeath = () {
    enemiesRemaining--;
  };

    gameRef.add(enemy);
  }
}
