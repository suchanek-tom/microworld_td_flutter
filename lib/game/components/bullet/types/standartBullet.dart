import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/baseBullet.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

class StandardBullet extends BaseBullet {
  StandardBullet({required Vector2 position, required BaseEnemy target, required int damage})
      : super(position: position, target: target, damage: damage, speed: 300);

  @override
  void hitTarget() {
    target?.takeDamage(damage);
    removeFromParent();
  }
}
