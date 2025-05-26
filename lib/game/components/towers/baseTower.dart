import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

abstract class BaseTower extends PositionComponent 
{
  bool inplacement = false;
  final double fireRate;
  final double range;
  final int damage;
  final String spritePath;
  final Vector2 spriteSize; 

  double timeSinceLastShot = 0;

  SpriteComponent? _spriteComponent;

  BaseTower({
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.spritePath,
    required this.spriteSize,
  }) {
    size = spriteSize;
  }

  @override
  Future<void> onLoad() async {
    try {
      final sprite = await Sprite.load(spritePath);
      _spriteComponent = SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      );
      add(_spriteComponent!);
    } catch (e) {
      print('❌ Failed to load sprite at "$spritePath". Error: $e');
    }
  }

  @override
  void update(double dt) 
  {
    super.update(dt);

    if(inplacement == false)
    {
      timeSinceLastShot += dt;

      final enemies = parent?.children
          .whereType<BaseEnemy>()
          .where((enemy) => position.distanceTo(enemy.position) < range)
          .toList();

      if (enemies == null || enemies.isEmpty) return;

      final target = enemies.first;

      if (_spriteComponent != null) {
        final direction = (target.position - position).normalized();
        _spriteComponent!.angle = direction.screenAngle();
      }

      if (timeSinceLastShot >= fireRate) {
        attackTarget(target);
        timeSinceLastShot = 0;
      }
    }
  }

  set setPos(Vector2 position)
  {
    this.position = position;
  }

  void attackTarget(BaseEnemy target);
}
