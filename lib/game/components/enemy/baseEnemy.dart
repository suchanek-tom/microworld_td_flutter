import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/game_state.dart';

abstract class BaseEnemy extends PositionComponent {
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

  BaseEnemy({
    required this.waypoints,
    required this.reward,
    required this.speed,
    required this.health,
    required this.enemyColor,
  }) {
    position = waypoints.first;
  }

  @override
  Future<void> onLoad() async {
    enemyBody = RectangleComponent(
      size: Vector2.all(20),
      paint: Paint()..color = enemyColor,
    );
    add(enemyBody);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (currentWaypointIndex < waypoints.length - 1) {
      moveToNextWaypoint(dt);
    } else {
      GameState.loseLife();
      removeFromParent();
    }

    if (isHit) handleHitEffect(dt);
    if (poisonDamage > 0) handlePoisonEffect(dt);
  }

  void moveToNextWaypoint(double dt) {
    Vector2 nextWaypoint = waypoints[currentWaypointIndex + 1];
    Vector2 direction = (nextWaypoint - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(nextWaypoint) < 5) {
      currentWaypointIndex++;
    }
  }

  void handleHitEffect(double dt) {
    hitTimer += dt;
    if (hitTimer > 0.1) {
      enemyBody.paint.color = enemyColor;
      isHit = false;
      hitTimer = 0;
    }
  }

  void handlePoisonEffect(double dt) {
    poisonTimer += dt;
    if (poisonTimer >= 1) {
      health -= poisonDamage;
      poisonTimer = 0;

      if (health <= 0) die();
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
    } else {
      enemyBody.paint.color = const Color(0xFFFF0000);
      isHit = true;
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
