import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'bullet.dart';
import '../enemy/enemy.dart';

class Tower extends PositionComponent {
  double fireRate = 0.5;
  double timeSinceLastShot = 0;
  double range = 200;
  int damage = 10;
  double slowEffect = 0.0;
  int poisonEffect = 0;
  Color towerColor = const Color(0xFF8B0000);

  Tower({required Vector2 position}) {
    this.position = position;
    size = Vector2(40, 40);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = towerColor,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastShot += dt;

    if (timeSinceLastShot < fireRate) return;

    final enemies = parent?.children.whereType<Enemy>().where((enemy) {
      return position.distanceTo(enemy.position) < range;
    });

    if (enemies == null || enemies.isEmpty) return;

    Enemy target = enemies.first;

    parent?.add(Bullet(
      position: position.clone(),
      target: target,
      damage: damage,
      slowEffect: slowEffect,
      poisonEffect: poisonEffect,
    ));

    timeSinceLastShot = 0;
  }
}
