import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Enemy extends PositionComponent {
  final List<Vector2> waypoints;
  final double speed = 10;
  int currentWaypointIndex = 0;
  int health = 70;
  bool isHit = false;
  double hitTimer = 0;

  late RectangleComponent enemyBody;

  Enemy({required this.waypoints}) {
    position = waypoints.first.clone(); 
    size = Vector2(30, 30);
  }

  @override
  Future<void> onLoad() async {
    enemyBody = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF00008B),
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
        enemyBody.paint.color = const Color(0xFF00008B);
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
}
