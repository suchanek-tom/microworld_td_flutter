import 'dart:ui';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

abstract class BaseBullet extends PositionComponent {
  final double speed;
  final int damage;
  BaseEnemy target;
  BaseTower tower;

  BaseBullet({
  required this.tower,
  required this.target,
  required this.damage,
  required this.speed,
  }) {
  position = tower.position.clone(); // Imposta la posizione del proiettile
  size = Vector2(4, 4);
  }

  @override
  Future<void> onLoad() async 
  {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFFFFFF00),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (target.isRemoved) {
      removeFromParent();
      return;
    }

    Vector2 direction = (target.position - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(target.position) < 8) {
      hitTarget();
    }
  }

  void hitTarget();
}
