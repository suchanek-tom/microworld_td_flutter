import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/abilities/abilities_imp/tela_abilita.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/game_state.dart';

enum Target{ first, close, strong}

abstract class BaseTower extends PositionComponent with HoverCallbacks
{
  bool inplacement = false;
  bool canto_buffed = false;
  bool canSeeCamo = false;

  final String towerName;
  final String sprite_icon_path;
  final String sprite_abl_sx_path;
  final String sprite_abl_dx_path;
  final String sprite_path;
  final Vector2 sprite_size; 
  late SpriteComponent sprite;
  late CircleComponent rangeCircle;

  bool hasLeft_ability = false;
  bool hasRight_ability = false;
  
  int cost;
  int cost_abl_sx;
  int cost_abl_dx;
  int sellCost;
  double fireRate;
  double range;
  int damage;
  List<int> upgradeCost = [];
  int towerLevel;
  String nome_abl_sx;
  String nome_abl_dx;
  BaseEnemy? target;
   
  Target typeTarget = Target.first;
  double timeSinceLastShot = 0;
  int antKilled = 0;

  BaseTower({
    required this.towerName,
    required this.fireRate,
    required this.range,
    required this.damage,
    required this.sprite_path,
    required this.sprite_size,
    required this.cost,
    required this.sellCost,  
    required this.sprite_icon_path, 
    required this.antKilled, 
    required this.upgradeCost, 
    required this.towerLevel, 
    required this.cost_abl_dx,
    required this.cost_abl_sx,
    required this.nome_abl_sx,
    required this.nome_abl_dx,
    required this.sprite_abl_dx_path,
    required this.sprite_abl_sx_path
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

      final borderCircle = CircleComponent(
        radius: range,
        paint: Paint()
          ..color = const Color.fromARGB(255, 41, 41, 41)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
        anchor: Anchor.center,
      );
      borderCircle.position = Vector2(width / 2, height / 2);

      rangeCircle = CircleComponent(
        radius: range,
        paint: Paint()
          ..color = const Color.fromARGB(80, 69, 69, 69) 
          ..style = PaintingStyle.fill
          ..strokeWidth = 2,
        anchor: Anchor.center,
      );
      rangeCircle.position = Vector2(width / 2, height / 2);

      add(borderCircle);
      add(rangeCircle);
      add(sprite);

    } catch (e) {
      print('❌ Failed to load sprite at "$sprite_path". Error: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

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

  static void sellTower(BaseTower towerToSell)
  {
    GameState.coins += towerToSell.sellCost;
    towerToSell.removeFromParent();
  }

  static Target changeTarget()
  {
    return Target.close;
  }
}
