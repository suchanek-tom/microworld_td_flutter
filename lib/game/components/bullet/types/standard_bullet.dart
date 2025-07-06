import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class StandardBullet extends BaseBullet {
  StandardBullet({required super.tower, required super.target, required super.damage})
      : super(speed: 300,bullet_size: Vector2.all(16),sprite_path: "bullets/base_bullet.webp",sprite_size: Vector2.all(32));

  @override
  void hitTarget() 
  {
    super.bulletDirection();
    target.takeDamage(damage,tower);
    removeFromParent();
  }
}
