import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:microworld_td/game/components/bullet.dart';
import 'package:microworld_td/game/components/enemy.dart';

class Tower extends PositionComponent {
  double fireRate = 0.5;
  double timeSinceLastShot = 0;

  Tower({required Vector2 position}) {
    this.position = position;
    size = Vector2(40, 40);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF8B0000),
    ));
  }

  @override
  void update(double dt){
    super.update(dt);

    timeSinceLastShot += dt;

    final enemies = parent?.children.whereType<Enemy>().toList();
    if (enemies == null || enemies.isEmpty) return;

    enemies.sort((a, b) => position.distanceTo(a.position).compareTo(position.distanceTo(b.position)));
    Enemy target = enemies.first;

      if (position.distanceTo(target.position) < 200 && timeSinceLastShot >= fireRate) {
      parent?.add(Bullet(position: position.clone(), targetPosition: target.position.clone()));
      timeSinceLastShot = 0; 
    }
  }
}
