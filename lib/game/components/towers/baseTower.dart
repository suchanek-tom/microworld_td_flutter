import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

abstract class BaseTower extends PositionComponent with HoverCallbacks
{
  bool inplacement = false;
  final String towerName;
  final double fireRate;
  final double range;
  final int damage;
  final String spritePath;
  final Vector2 spriteSize; 

  double timeSinceLastShot = 0;

  late final SpriteComponent sprite;

  BaseTower({
    required this.towerName,
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.spritePath,
    required this.spriteSize,
  }) {
    size = spriteSize;
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    try {
      sprite = SpriteComponent(
        sprite: await Sprite.load(spritePath),
        size: size,
        anchor: Anchor.center,
      );

      sprite.position = Vector2(width / 2, height / 2);

      add(sprite);
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

      final direction = (target.position - position).normalized();
      sprite.angle = direction.screenAngle();
    
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

  @override
  void onHoverEnter() 
  {
    sprite.opacity = 0.7;
    print("lezzo $position");
    super.onHoverEnter();
  }

  @override
  void onHoverExit() 
  {
    sprite.opacity = 1;
    super.onHoverExit();
  }

  void attackTarget(BaseEnemy target);
}
