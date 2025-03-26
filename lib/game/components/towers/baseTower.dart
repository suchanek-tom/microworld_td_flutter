import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

abstract class BaseTower extends PositionComponent {
  double fireRate;
  double range;
  int damage;
  Color towerColor;
  double timeSinceLastShot = 0;

  BaseTower({
    required Vector2 position,
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.towerColor,
  }) {
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

    final enemies = parent?.children.whereType<BaseEnemy>().where((enemy) {
      return position.distanceTo(enemy.position) < range;
    }).toList();

    if (enemies == null || enemies.isEmpty) return;

    attackTarget(enemies.first);
    timeSinceLastShot = 0;
  }

  void attackTarget(BaseEnemy target);
}
