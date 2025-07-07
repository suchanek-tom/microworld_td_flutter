import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class MudBullet extends BaseBullet {
  MudBullet({required super.tower, required super.target, required super.damage})
    : super(speed: 250,bullet_size: Vector2.all(32),sprite_path: "bullets/dirt_ball_bullet.webp",);

  @override
  void hitTarget() 
  {
    super.bulletDirection();
    target.takeDamage(damage,tower);
    removeFromParent();
  }
}