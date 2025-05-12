import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

abstract class BaseTower extends PositionComponent {
  final double fireRate;
  final double range;
  final int damage;
  final String spritePath;
  final Vector2 spriteSize;

  double timeSinceLastShot = 0;

  BaseTower({
    required Vector2 position,
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.spritePath,
    required this.spriteSize,
  }) {
    this.position = position;
    size = spriteSize;
  }

  @override
  Future<void> onLoad() async {
    try {
      final sprite = await Sprite.load(spritePath);
      add(SpriteComponent(sprite: sprite, size: size));
    } catch (e) {
      print('❌ Failed to load sprite at "$spritePath". Error: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastShot += dt;

    if (timeSinceLastShot < fireRate) return;

    final enemies = parent?.children
        .whereType<BaseEnemy>()
        .where((enemy) => position.distanceTo(enemy.position) < range)
        .toList();

    if (enemies == null || enemies.isEmpty) return;

    attackTarget(enemies.first);
    timeSinceLastShot = 0;
  }

  void attackTarget(BaseEnemy target);
}
