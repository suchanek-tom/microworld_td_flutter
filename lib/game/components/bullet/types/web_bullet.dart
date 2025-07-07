import 'dart:async' as dartasync;
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class WebBullet extends BaseBullet {
  double moltiplicatore_danni = 0.8;
  double slowFactor = 90;
  double durataEffetto = 3.0;

  WebBullet({required super.tower, required super.target, required super.damage,}) 
    : super(speed: 200, bullet_size: Vector2.all(32), sprite_path: "bullets/web.webp");

  @override
  void hitTarget()
  {
    final originalSpeed = target.speed;
    target.speed *= (1 - slowFactor / 100);
    target.moltiplicatore_danni = moltiplicatore_danni;
    removeFromParent();
    dartasync.Timer(Duration(seconds: durataEffetto.toInt()), () 
    {
      if (!target.isRemoved) {
        target.speed = originalSpeed;
        target.moltiplicatore_danni = 0;
      }
    });
  }
}