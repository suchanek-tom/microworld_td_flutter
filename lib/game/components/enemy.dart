import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Enemy extends PositionComponent {
  final Vector2 targetPosition;
  final double speed = 30;
  int health = 30;
  bool isHit = false;
  double hitTimer = 0;

  late RectangleComponent enemyBody;

  Enemy({required Vector2 position, required this.targetPosition}) {
    this.position = position;
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

    Vector2 direction = (targetPosition - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(targetPosition) < 5) {
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
