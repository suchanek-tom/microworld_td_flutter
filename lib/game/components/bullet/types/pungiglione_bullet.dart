import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class PungiglioneBullet extends BaseBullet 
{
  double poison_time = 5;
  int poison_damage = 15;

  PungiglioneBullet({required super.tower, required super.target, required super.damage})
    : super(speed: 300, bullet_size: Vector2.all(24), sprite_path: "bullets/poison_bullet.webp",);

  @override
  void hitTarget() 
  {
    target.poisonTimer = poison_time; 
    super.bulletDirection();
    target.takeDamage(damage, tower);
    target.applyPoison(poison_damage);
    removeFromParent();
  }
}