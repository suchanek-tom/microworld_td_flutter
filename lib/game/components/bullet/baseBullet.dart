import 'dart:ui';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

abstract class BaseBullet extends PositionComponent {
  final double speed;
  final int damage;
  BaseEnemy? target;

  BaseBullet({
    required Vector2 position,
    required this.target,
    required this.damage,
    required this.speed,
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
      hitTarget();
    }
  }

  void hitTarget();
}
