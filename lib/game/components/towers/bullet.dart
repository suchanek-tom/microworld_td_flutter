import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import '../enemy/enemy.dart';

class Bullet extends PositionComponent {
  final double speed = 300;
  final int damage;
  final double slowEffect;
  final int poisonEffect;
  Enemy? target;

  Bullet({
    required Vector2 position,
    required this.target,
    required this.damage,
    this.slowEffect = 0.0,
    this.poisonEffect = 0,
  }) {
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

    if (target == null || target!.isRemoved) {
      removeFromParent();
      return;
    }

    Vector2 direction = (target!.position - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(target!.position) < 8) {
      target!.takeDamage(damage);
      
      if (slowEffect > 0) {
        target!.speed *= slowEffect;
      }

      if (poisonEffect > 0) {
        target!.applyPoison(poisonEffect);
      }

      removeFromParent();
    }
  }
}
