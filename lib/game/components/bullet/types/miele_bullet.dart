import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class MieleBullet extends BaseBullet with CollisionCallbacks {
  final void Function(MieleBullet) onDestroy;
  double radius = 18;
  double duration;
  final double slowFactor = 0.5;

  bool _reachedTarget = false;

  MieleBullet({
    required super.tower,
    required super.target,
    required super.damage,
    required this.onDestroy,
    required this.duration,
  }) : super(
    speed: 200,
    bullet_size: Vector2.all(48),
    sprite_path: "bullets/miele.webp",
  ){
    priority = 1;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad(); 
    add(CircleHitbox());

    sprite.anchor = Anchor.center;
    sprite.position = size / 2;
  }

  @override
  void update(double dt) {
    if (_reachedTarget) {
      duration -= dt;
      if (duration <= 0) {
        onDestroy(this);
        removeFromParent();
      }
      return;
    }

    if (target.isRemoved) {
      removeFromParent();
      return;
    }

    Vector2 direction = (target.position - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(target.position) < 8) {
      hitTarget();
    }
  }

  @override
  void hitTarget() {
    _reachedTarget = true;

    position = position.clone();
  }
}