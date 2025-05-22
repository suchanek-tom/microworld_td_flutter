import 'dart:ui';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/game_state.dart';

abstract class BaseEnemy extends PositionComponent {
  final List<Vector2> waypoints;
  final double speed;
  final int reward;
  final String spritePath;
  final Vector2 spriteSize;

  int health;
  int currentWaypointIndex = 0;

  bool isHit = false;
  double hitTimer = 0;
  int poisonDamage = 0;
  double poisonTimer = 0;

  double originalOpacity = 1.0;

  SpriteComponent? spriteComponent;
  VoidCallback? onDeath;

  BaseEnemy({
    required this.waypoints,
    required this.reward,
    required this.speed,
    required this.health,
    required this.spritePath,
    required this.spriteSize,
  }) {
    position = waypoints.first;
    size = spriteSize;
  }

  @override
  Future<void> onLoad() async {
    try {
      final sprite = await Sprite.load(spritePath);
      spriteComponent = SpriteComponent(sprite: sprite, size: size);
      add(spriteComponent!);
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

    if (isHit) handleHitEffect(dt);
    if (poisonDamage > 0) handlePoisonEffect(dt);
  }

  void moveToNextWaypoint(double dt) {
    final nextWaypoint = waypoints[currentWaypointIndex + 1];
    final direction = (nextWaypoint - position).normalized();
    position += direction * speed * dt;

    if (position.distanceTo(nextWaypoint) < 5) {
      currentWaypointIndex++;
    }
  }

  void handleHitEffect(double dt) {
    hitTimer += dt;
    if (hitTimer > 0.1) {
      spriteComponent?.opacity = originalOpacity;
      isHit = false;
      hitTimer = 0;
    }
  }

  void handlePoisonEffect(double dt) {
    poisonTimer += dt;
    if (poisonTimer >= 1) {
      health -= poisonDamage;
      poisonTimer = 0;

      if (health <= 0) die();
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
      onDeath?.call();
    } else {
      spriteComponent?.opacity = 0.6; // hit efekt
      isHit = true;
    }
  }

  void applyPoison(int poisonDamage) {
    this.poisonDamage = poisonDamage;
  }

  void die() {
    GameState.addCoins(reward);
    removeFromParent();
  }
}
