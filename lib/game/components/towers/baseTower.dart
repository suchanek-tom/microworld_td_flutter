import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';

enum Target{ first, close, strong}

abstract class BaseTower extends PositionComponent with HoverCallbacks
{
  bool inplacement = false;

  final String towerName;
  final String sprit_icon_path;
  final String sprite_path;
  final Vector2 sprite_size; 
  late SpriteComponent sprite;
  late CircleComponent rangeCircle;

  late List<AbilitiesActionService> left_abilities = [];
  late List<AbilitiesActionService> right_abilities = [];
  
  int cost;
  int sellCost;
  double fireRate;
  double range;
  int damage;
  List<int> upgradeCost = [];
  int towerLevel;
  BaseEnemy? target;
   
  Target typeTarget = Target.first;
  double timeSinceLastShot = 0;
  int antKilled = 0;
  int exp_torre = 0;

  BaseTower({
    required this.towerName,
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.sprite_path,
    required this.sprite_size,
    required this.cost,
    required this.sellCost,  
    required this.sprit_icon_path, 
    required this.antKilled, 
    required this.upgradeCost, 
    required this.towerLevel, 
  }) 
  {
    size = sprite_size;
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    try {
      sprite = SpriteComponent(
        sprite: await Sprite.load(sprite_path),
        size: size,
        anchor: Anchor.center,
      );

      sprite.position = Vector2(width / 2, height / 2);

      rangeCircle = CircleComponent(
        radius: range,
        paint: Paint()
          ..color = const Color.fromARGB(222, 255, 25, 4) 
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
        anchor: Anchor.center,
      );
      rangeCircle.position = Vector2(width / 2, height / 2);
      add(rangeCircle);


      add(sprite);
    } catch (e) {
      print('❌ Failed to load sprite at "$sprite_path". Error: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    /*
    if(inplacement == false)
    {
      timeSinceLastShot += dt;

      final enemies = parent?.children
          .whereType<BaseEnemy>()
          .where((enemy) => position.distanceTo(enemy.position) < range)
          .toList();

      if (enemies == null || enemies.isEmpty) return;

      final target = enemies.first;

      final direction = (target.position - position).normalized();
      sprite.angle = direction.screenAngle();
    
      if (timeSinceLastShot >= fireRate) {
        attackTarget(target);
        timeSinceLastShot = 0;
      }
    }
    */

    if (inplacement == false) 
    {
      timeSinceLastShot += dt;

      // Trova tutti i nemici nel range
      final enemiesInRange = parent?.children
        .whereType<BaseEnemy>()
        .where((enemy) => !enemy.isRemoved) // Protezione in più
        .where((enemy) => position.distanceTo(enemy.position) < range)
        .toList();

      // Se non ci sono nemici nel range, azzera il target e esci
      if (enemiesInRange == null || enemiesInRange.isEmpty) 
      {
        target = null;
        return;
      }

      // Se non abbiamo un target valido, prendine uno nuovo
      target = enemiesInRange.first;

      final direction = (target!.position - position).normalized();
      sprite.angle = direction.screenAngle();

      if (timeSinceLastShot >= fireRate) {
        attackTarget(target!);
        timeSinceLastShot = 0;
      }
    }
  }

  set setPos(Vector2 position)
  {
    this.position = position;
  }

  @override
  void onHoverEnter() 
  {
    sprite.opacity = 0.7;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() 
  {
    sprite.opacity = 1;
    super.onHoverExit();
  }

  void attackTarget(BaseEnemy target);

  void implementUpgrade(int side, BaseTower tower);

  int sellTower(BaseTower towerToSell);

  static Target changeTarget()
  {
    return Target.close;
  }
}
