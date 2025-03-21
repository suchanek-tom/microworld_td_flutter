import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

//Parent component
class Enemy extends PositionComponent {
  final List<Vector2> waypoints;
  double speed;
  int health;
  int currentWaypointIndex = 0;
  bool isHit = false;
  double hitTimer = 0;
  Color enemyColor = const Color(0xFF00008B);

  late RectangleComponent enemyBody;

  Enemy({
    required this.waypoints,
    this.speed = 10,
    this.health = 70,
  }) {
    position = waypoints.first.clone();
    size = Vector2(30, 30);
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
  }

  void takeDamage(int damage) {
    health -= damage;
    enemyBody.paint.color = const Color(0xFFFF0000); 
    isHit = true;

    if (health <= 0) {
      removeFromParent();
    }
  }

  void applyPoison(int poisonDamage) {
  health -= poisonDamage;
  }
}
