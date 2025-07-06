import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/bullet/types/splash_bullet.dart';
import 'dart:math';
import 'package:microworld_td/game/components/towers/baseTower.dart';
class DannoAdAreaAbilita extends Component implements AbilitiesActionService {

  final rng = Random();
  final BaseTower tower;

  @override
  String ability_name;

  double frequenza = 0.5;
  double cooldown = 5; // tempo di blocco dopo attivazione
  double probabilita = 0.15;

  late Timer _frequenzaTimer;
  late Timer _cooldownTimer;
  bool _frequenzaRunning = false;
  bool _onCooldown = false;

  DannoAdAreaAbilita({required this.tower ,required this.ability_name}){
    _frequenzaTimer = Timer(frequenza, repeat: true, onTick: probabilita_splash_damage);

    _cooldownTimer = Timer(cooldown, onTick: () {
      _onCooldown = false;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

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
  void ability() {
     tower.parent?.add(SplashBullet(tower: tower, target: tower.target!, damage: 50));
  }

  void probabilita_splash_damage() 
  {
    final target = tower.target;
    if (target == null || target.isRemoved) return;

    final p = rng.nextDouble();
    if (p < probabilita) {
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
