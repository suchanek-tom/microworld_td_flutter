import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import '../game_state.dart';

class Enemy extends PositionComponent {
  final List<Vector2> waypoints;
  double speed;
  int health;
  int currentWaypointIndex = 0;
  bool isHit = false;
  double hitTimer = 0;
  Color enemyColor;
  int reward;
  int poisonDamage = 0;
  double poisonTimer = 0;

  late RectangleComponent enemyBody;

  Enemy({
    required this.waypoints,
    required this.reward,
    required this.speed,
    required this.health,
    required this.enemyColor,
  }) {
    position = waypoints.first.clone();
  }

  @override
  Future<void> onLoad() async {
    enemyBody = RectangleComponent(
      size: size,
      paint: Paint()..color = enemyColor,
    );
    add(enemyBody);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (currentWaypointIndex < waypoints.length - 1) {
      Vector2 nextWaypoint = waypoints[currentWaypointIndex + 1];
      Vector2 direction = (nextWaypoint - position).normalized();
      position += direction * speed * dt;

      if (position.distanceTo(nextWaypoint) < 5) {
        currentWaypointIndex++;
        position = nextWaypoint.clone();
      }
    } else {
      removeFromParent();
    }

    if (isHit) {
      hitTimer += dt;
      if (hitTimer > 0.1) {
        enemyBody.paint.color = enemyColor;
        isHit = false;
        hitTimer = 0;
      }
    }

    if (poisonDamage > 0) {
      poisonTimer += dt;
      if (poisonTimer >= 1) { 
        health -= poisonDamage;
        poisonTimer = 0;

        if (health <= 0) {
          die();
        }
      }
    }

      if (currentWaypointIndex >= waypoints.length - 1) {
      GameState.loseLife();  
      removeFromParent();
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    enemyBody.paint.color = const Color(0xFFFF0000);
    isHit = true;

    if (health <= 0) {
      die();
    }
  }

  void applyPoison(int poisonDamage) {
    this.poisonDamage = poisonDamage;
  }

  void die() {
    GameState.addCoins(reward);
    removeFromParent();
  }
}
