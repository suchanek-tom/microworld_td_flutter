import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class SonarBullet extends BaseBullet {
  SonarBullet({required super.tower, required super.target, required super.damage})
      : super(speed: 450,bullet_size: Vector2.all(32),sprite_path: "bullets/onde.webp",);

  @override
  void hitTarget() 
  {
    super.bulletDirection();
    target.takeDamage(damage,tower);
    removeFromParent();
  }
}
