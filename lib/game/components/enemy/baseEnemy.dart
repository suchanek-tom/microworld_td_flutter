import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/game_state.dart';

enum StatusEffect { none, poisoned, slowed }

abstract class BaseEnemy extends PositionComponent {
  final List<Vector2> waypoints;
  final int reward;
  final String spritePath;
  final Vector2 spriteSize;

  late final SpriteComponent sprite;
  late double baseSpeed;
  late double speed;
  double speedMultiplier = 1.0;

  int health;
  int currentWaypointIndex = 0;

  bool isHit = false;
  double hitTimer = 0;

  // Poison
  int poisonDamage = 0;
  double poisonTimer = 0;

  // Slow
  double slowDuration = 0;

  double originalOpacity = 1.0;
  double currentAngle = 0.0;

  StatusEffect status = StatusEffect.none;
  VoidCallback? onDeath;

  BaseEnemy({
    required this.waypoints,
    required this.reward,
    required double speed,
    required this.health,
    required this.spritePath,
    required this.spriteSize,
  }) {
    this.baseSpeed = speed;
    this.speed = speed;
    size = spriteSize;
    anchor = Anchor.center;
    position = waypoints.first;
  }

  @override
  Future<void> onLoad() async {
    try {
      sprite = SpriteComponent(
        sprite: await Sprite.load(spritePath),
        size: size,
        anchor: Anchor.center,
      );
      sprite.position = Vector2(width / 2, height / 2);

      // Počáteční otočení směrem k prvnímu cíli
      if (waypoints.length > 1) {
        final initialDirection = waypoints[1] - waypoints[0];
        final initialNormalized = initialDirection.normalized();
        final initialAngle = math.atan2(initialNormalized.y, initialNormalized.x) + math.pi / 2;

        currentAngle = initialAngle;
        sprite.angle = currentAngle;
      }

      add(sprite);
    } catch (e) {
      print('❌ Failed to load enemy sprite at "$spritePath". Error: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (currentWaypointIndex < waypoints.length - 1) {
      moveToNextWaypoint(dt);
    } else {
      GameState.loseLife();
      removeFromParent();
      return;
    }

    if (isHit) handleHitEffect(dt);
    if (status == StatusEffect.poisoned) handlePoisonEffect(dt);
    if (status == StatusEffect.slowed) handleSlowEffect(dt);
  }

  void moveToNextWaypoint(double dt) {
    final nextWaypoint = waypoints[currentWaypointIndex + 1];
    final direction = nextWaypoint - position;
    final normalized = direction.normalized();

    position += normalized * speed * dt;

    final targetAngle = math.atan2(normalized.y, normalized.x) + math.pi / 2;
    currentAngle = _lerpAngle(currentAngle, targetAngle, dt * 5);
    sprite.angle = currentAngle;

    if (position.distanceTo(nextWaypoint) < 5) {
      currentWaypointIndex++;
    }
  }

  double _lerpAngle(double a, double b, double t) {
    double diff = b - a;
    while (diff < -math.pi) diff += 2 * math.pi;
    while (diff > math.pi) diff -= 2 * math.pi;
    return a + diff * t;
  }

  void handleHitEffect(double dt) {
    hitTimer += dt;
    if (hitTimer > 0.1) {
      sprite.opacity = originalOpacity;
      isHit = false;
      hitTimer = 0;
    }
  }

  void handlePoisonEffect(double dt) {
    poisonTimer += dt;
    if (poisonTimer >= 1) {
      health -= poisonDamage;
      poisonTimer = 0;

      if (health <= 0) {
        die();
      }
    }
  }

  void handleSlowEffect(double dt) {
    slowDuration -= dt;
    if (slowDuration <= 0) {
      speed = baseSpeed;
      status = StatusEffect.none;
    }
  }

  void takeDamage(int damage) {
    health -= damage;

    if (health <= 0) {
      die();
    } else {
      sprite.opacity = 0.4;
      isHit = true;
    }
  }

  void applyPoison(int damagePerSecond) {
    poisonDamage = damagePerSecond;
    poisonTimer = 0;
    status = StatusEffect.poisoned;
  }

  void applySlow(double multiplier, double duration) {
    speed = baseSpeed * multiplier;
    slowDuration = duration;
    status = StatusEffect.slowed;
  }

  void die() {
    GameState.addCoins(reward);
    onDeath?.call();
    removeFromParent();
  }
}
