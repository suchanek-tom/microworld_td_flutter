import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class SplashBullet extends BaseBullet {
  int splash_range = 20;
  String sprite_path_esplosione = "bullets/esplosione.webp";

  SplashBullet({required super.tower, required super.target, required super.damage}) 
    : super(speed: 300, bullet_size: Vector2.all(32), sprite_path: "bullets/bomba.webp",);

  @override
  void hitTarget () async
  {
    target.takeDamage(damage,tower);

    try {    
      sprite.sprite = await Sprite.load(sprite_path_esplosione);
      sprite.size = Vector2.all(128); 
     
      sprite.position = Vector2(width / 2, height / 2);

      add(sprite);
    } catch (e) {
      print('❌ Failed to load sprite at "$sprite_path". Error: $e');
    }
    await Future.delayed(const Duration(milliseconds: 250));
    removeFromParent();   
  }
}
