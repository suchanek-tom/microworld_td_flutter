import 'package:flame/components.dart';
import 'enemy.dart';

class EnemySpawner extends Component with HasGameRef {
  final List<Vector2> waypoints;
  final double spawnInterval; 
  double timer = 0;
  int enemiesToSpawn;

  EnemySpawner({
    required this.waypoints,
    this.spawnInterval = 2.0,
    this.enemiesToSpawn = 10, 
  });

  @override
  void update(double dt) {
    super.update(dt);

    if (enemiesToSpawn <= 0) return; // No more enemies to spawn

    timer += dt;
    if (timer >= spawnInterval) {
      timer = 0;
      final enemy = Enemy(waypoints: waypoints);
      gameRef.add(enemy); // Add the enemy to the game
      enemiesToSpawn--; // Decrease the number of enemies to spawn
    }
  }
}
