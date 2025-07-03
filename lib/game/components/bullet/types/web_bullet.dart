import 'dart:async' as dartasync;
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class WebBullet extends BaseBullet {
  double moltiplicatore_danni = 0.8;
  double slowFactor = 90;         // Velocità ridotta al 90%
  double durataEffetto = 3.0;      // In secondi

  WebBullet({required super.tower, required super.target, required super.damage,}) 
    : super(speed: 200, bullet_size: Vector2.all(16), sprite_path: "bullets/web.webp",sprite_size: Vector2.all(64));

  @override
  void hitTarget() {
    final originalSpeed = target.speed;
    // Applica rallentamento
    target.speed *= (1 - slowFactor / 100);
    target.moltiplicatore_danni = moltiplicatore_danni;
    removeFromParent();
    // Dopo 3 secondi ripristina la velocità
    dartasync.Timer(Duration(seconds: durataEffetto.toInt()), () 
    {
      // Controlla che il nemico sia ancora valido
      if (!target.isRemoved) {
        target.speed = originalSpeed;
        target.moltiplicatore_danni = 0;
      }
    });
  }
}