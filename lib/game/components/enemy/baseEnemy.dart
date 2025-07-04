import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

abstract class BaseEnemy extends PositionComponent 
{
  final String antName;
  final List<Vector2> waypoints;
  double speed;
  final int reward;
  final String spritePath;
  final Vector2 spriteSize;

  double moltiplicatore_danni = 0;

  BaseTower? taking_hit_from;
  int health;
  int currentWaypointIndex = 0;

  bool isHit = false;
  double hitTimer = 0;
  int poisonDamage = 0;
  double poisonTimer = 0;
  double tickAccumulator = 0;
  final double tickInterval = 1.5; 

  double originalOpacity = 1.0;

  late final SpriteComponent sprite;

  double currentAngle = 0.0;

  BaseEnemy({
    required this.antName,
    required this.waypoints,
    required this.reward,
    required this.speed,
    required this.health,
    required this.spritePath,
    required this.spriteSize,
  }) {
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
    }

    if (isHit) resetHitEffect(dt);
    if (poisonDamage > 0) handlePoisonEffect(dt);
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

    while (diff < -math.pi) {
      diff += 2 * math.pi;
    }
    while (diff > math.pi) {
      diff -= 2 * math.pi;
    }

    return a + diff * t;
  }

  void resetHitEffect(double dt) {
    hitTimer += dt;
    if (hitTimer > 0.1) {
      sprite.paint = Paint();
      isHit = false;
      hitTimer = 0;
    }
  }

  void hitEffect()
  {
    sprite.paint = Paint()
      ..colorFilter = const ColorFilter.mode(
      Color(0x66FF0000), // Rosso semi-trasparente
      BlendMode.srcATop,
      );
  }

  void handlePoisonEffect(double dt) {
  if (poisonTimer > 0) {
    poisonTimer -= dt;
    tickAccumulator += dt;

    if (tickAccumulator >= tickInterval) {
      tickAccumulator = 0;

      health -= poisonDamage;
      hitEffect(); // effetto visivo
      isHit = true;
      if (health <= 0) {
        poisonTimer = 0;
        die(taking_hit_from!);
      }
    }
  }
  }

  void takeDamage(int damage, BaseTower tower) 
  {
    taking_hit_from = tower;
    damage = damage * (1 + moltiplicatore_danni) as int;
    health -= damage;
    if (health <= 0) 
    {
      die(taking_hit_from!);
    } else {
      hitEffect();
      isHit = true;
    }
  }

  void applyPoison(int poisonDamage) {
    this.poisonDamage = poisonDamage;
    sprite.paint = Paint()
      ..colorFilter = const ColorFilter.mode(
      Color.fromARGB(102, 166, 0, 255), // viola semi-trasparente
      BlendMode.srcATop,
      );
  }

  void die(BaseTower killer) 
  {
    GameState.addCoins(reward);
    GameState.enemiesRemaining --;
    killer.antKilled++;

    if (killer.target == this) {
    killer.target = null;
    }
    removeFromParent();
  }
}
