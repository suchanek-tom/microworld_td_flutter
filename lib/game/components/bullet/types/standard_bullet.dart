import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class StandardBullet extends BaseBullet {
  StandardBullet({required super.tower, required super.target, required super.damage})
      : super(speed: 300);

  @override
  void hitTarget() 
  {
    target.takeDamage(damage,tower);
    removeFromParent();
  }
}
