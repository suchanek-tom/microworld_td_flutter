import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class PallaDiFangoAbilita extends Component implements AbilitiesActionService {

  @override
  String ability_name;

  final rng = Random();
  final BaseTower tower;

  double frequenza = 0.5;
  double cooldown = 150; // tempo di blocco dopo attivazione
  double probabilita = 0.1;

  late Timer _frequenzaTimer;
  late Timer _cooldownTimer;

  bool _frequenzaRunning = false;
  bool _onCooldown = false;

  PathComponent? palla_path;


  PallaDiFangoAbilita({required this.ability_name, required this.tower}){
      palla_path = tower.parent?.children.whereType<PathComponent>().firstOrNull;
  
     _frequenzaTimer = Timer(
        frequenza, 
        repeat: true, 
        onTick: probabilita_palla);

      _cooldownTimer = Timer(cooldown, onTick: () {
      _onCooldown = false;
    });
  }

   @override
  void update(double dt) 
  {
    final hasTarget = tower.target != null && !tower.target!.isRemoved;

    // Avvia il timer solo se c'è un target e non siamo in cooldown
    if (hasTarget && !_frequenzaRunning && !_onCooldown) {
      _frequenzaTimer.start();
      _frequenzaRunning = true;
    }

    // Ferma il timer se non c’è più un target
    if (!hasTarget && _frequenzaRunning) {
      _frequenzaTimer.stop();
      _frequenzaRunning = false;
    }

    if (_frequenzaRunning && !_onCooldown) {
      _frequenzaTimer.update(dt);
    }

    if (_onCooldown) {
      _cooldownTimer.update(dt);
    }
  }

  @override
  void ability() 
  {
    var pathPoints = List<Vector2>.from(palla_path!.waypoints.reversed);
    _PallaDiFango(palla_path: pathPoints,tower: tower);
  }

  void probabilita_palla() 
  {
    final p = rng.nextDouble();
    if (p < probabilita)
    {
      ability();
      // Entra in cooldown dopo attivazione
      _onCooldown = true;
      _frequenzaTimer.stop();  // ferma temporaneamente il check
      _frequenzaRunning = false;
      _cooldownTimer.start();  // parte il cooldown
    }
  }
}

class _PallaDiFango extends PositionComponent with CollisionCallbacks
{ 
  List<Vector2> palla_path;
  int danno_palla = 300;
  BaseTower tower;
  int currentTargetIndex = 0;

  final double speed = 150;
  late SpriteComponent sprite_palla;
  String sprite_path = "bullets/dirt_ball.webp";

  _PallaDiFango({required this.palla_path, required this.tower});

   @override
  Future<void> onLoad() async {
   
    position = palla_path.first.clone();
    size = Vector2.all(48);
    anchor = Anchor.center;

    try {
    sprite_palla = SpriteComponent(
      sprite: await Sprite.load(sprite_path),
      size: size,
      anchor: Anchor.center,
    );

    add(sprite_palla);
    add(CircleHitbox());
     } catch (e) {
      print('❌ Failed to load sprite at "$sprite_path". Error: $e');
    }
  }

  
  @override
  void update(double dt) {
    super.update(dt);

    if (currentTargetIndex >= palla_path.length) {
      removeFromParent();
      return;
    }

    final target = palla_path[currentTargetIndex];
    final direction = (target - position);

    if (direction.length < 2) {
      currentTargetIndex++;
    } else {
      final move = direction.normalized() * speed * dt;
      position += move;

      // Rotazione verso il prossimo target
      sprite_palla.angle = direction.screenAngle();
    }

    @override
    void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
      super.onCollision(intersectionPoints, other);
      if (other is BaseEnemy) {
        other.takeDamage(danno_palla, tower);
      }
    }
  }
}



  

