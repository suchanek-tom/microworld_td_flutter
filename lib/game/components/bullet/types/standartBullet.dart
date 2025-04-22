import 'package:microworld_td/game/components/bullet/baseBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class StandardBullet extends BaseBullet {
  StandardBullet({required super.position, required BaseEnemy super.target, required super.damage})
      : super(speed: 300);

  @override
  void hitTarget() {
    target?.takeDamage(damage);
    removeFromParent();
  }
}
