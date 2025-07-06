import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class MieleAbilita extends Component implements AbilitiesActionService
{

  int max_miele_percorso = 4;
  int current_miele_percorso = 0;

  final rng = Random();
  final BaseTower tower;

  final double duration = 45; //45 sec
  final double slowFactor = 0.5; //rallenta del 50%

  double frequenza = 0.5;
  double cooldown = 10; // tempo di blocco dopo attivazione
  double probabilita = 0.5;

  late Timer _frequenzaTimer;
  late Timer _cooldownTimer;
  bool _frequenzaRunning = false;
  bool _onCooldown = false;

  @override
  String ability_name;

  MieleAbilita({required this.ability_name, required this.tower}){
      _frequenzaTimer = Timer(
        frequenza, 
        repeat: true, 
        onTick: probabilita_miele);

     _cooldownTimer = Timer(cooldown, onTick: () {
      _onCooldown = false;
    });
  }


  @override
  void update(double dt) {
    super.update(dt);

    if (!_frequenzaRunning && !_onCooldown) {
      _frequenzaTimer.start();
      _frequenzaRunning = true;
    }

    // Ferma il timer se non c’è più un target
    if (_frequenzaRunning) {
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
  void ability() {
    // TODO: implement ability
  }

  void probabilita_miele()
  {
    current_miele_percorso<= max_miele_percorso ? current_miele_percorso ++: current_miele_percorso;
    final p = rng.nextDouble();
    if (p < probabilita && current_miele_percorso <= max_miele_percorso)
    {
      ability();
      // Entra in cooldown dopo attivazione
      _onCooldown = true;
      _frequenzaTimer.stop();  // ferma temporaneamente il check
      _frequenzaRunning = false;
      _cooldownTimer.start();  // parte il cooldown
    }
  }

  void stop() {
    _frequenzaTimer.stop();
    _cooldownTimer.stop();
    _frequenzaRunning = false;
    _onCooldown = false;
  } 
}


class Miele extends PositionComponent
{
  
  @override
  Future<void> onLoad() async 
  {
    double radius = 5;
    add(CircleHitbox());

    // visualizzazione (facoltativa)
    add(
      CircleComponent(
        radius: radius,
        paint: Paint()..color = const Color.fromARGB(99, 255, 0, 0),
        anchor: Anchor.center,
      ),
    );

    // Rimozione automatica dopo duration
    /* await Future.delayed(Duration(seconds: duration.toInt()));
    removeFromParent(); */
  }
}
  

