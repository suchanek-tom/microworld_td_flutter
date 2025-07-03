import 'dart:async';

import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

abstract class BaseBullet extends PositionComponent {
  final double speed;
  final int damage;
  BaseEnemy target;
  BaseTower tower;
  
  final Vector2 bullet_size;
  final String sprite_path;
  final Vector2 sprite_size; 
  late SpriteComponent sprite;


  BaseBullet({
  required this.tower,
  required this.target,
  required this.damage,
  required this.speed,
  required this.sprite_path,
  required this.sprite_size,
  required this.bullet_size,
  }) {
  position = tower.position.clone(); // Imposta la posizione del proiettile
  size = bullet_size;
  }

  @override
  Future<void> onLoad() async {
     try {
      sprite = SpriteComponent(
        sprite: await Sprite.load(sprite_path),
        size: size,
        anchor: Anchor.center,
      );

      sprite.position = Vector2(width / 2, height / 2);

      add(sprite);
    } catch (e) {
      print('❌ Failed to load sprite at "$sprite_path". Error: $e');
    }
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
