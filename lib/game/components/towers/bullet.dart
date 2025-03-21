import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import '../enemy/enemy.dart';

class Bullet extends PositionComponent {
  final Vector2 targetPosition;
  final double speed = 300;
  final int damage = 5;
  bool hitTarget = false;

  Bullet({required Vector2 position, required this.targetPosition}) {
    this.position = position;
    size = Vector2(8, 8);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFFFFFF00),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hitTarget) {
      removeFromParent();
      return;
    }

    Vector2 direction = (targetPosition - position).normalized();
    position += direction * speed * dt;

    final enemies = parent?.children.whereType<Enemy>().toList();
    for (var enemy in enemies!) {
      if (enemy.position.distanceTo(position) < 15) {
        enemy.takeDamage(damage);
        hitTarget = true;
        break;
      }
    }
  }
}
