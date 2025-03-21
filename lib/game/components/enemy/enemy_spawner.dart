import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/enemy.dart';
import 'dart:math';
import 'types/worker_ant.dart';
import 'types/armored_beetle.dart';
import 'types/fast_bug.dart';
import 'types/queens_guard.dart';

class EnemySpawner extends Component with HasGameRef {
  final List<Vector2> waypoints;
  final double spawnInterval;
  double timer = 0;
  int enemiesToSpawn;
  final Random random = Random();

  EnemySpawner({
    required this.waypoints,
    this.spawnInterval = 2.0,
    this.enemiesToSpawn = 10,
  });

  @override
  void update(double dt) {
    super.update(dt);

    if (enemiesToSpawn <= 0) return;

    timer += dt;
    if (timer >= spawnInterval) {
      timer = 0;
      spawnRandomEnemy();
      enemiesToSpawn--;
    }
  }

  void spawnRandomEnemy() {
    final int enemyType = random.nextInt(4);
    late Enemy enemy;

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

    gameRef.add(enemy);
  }
}
