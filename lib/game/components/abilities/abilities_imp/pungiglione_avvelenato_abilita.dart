import 'dart:math';

import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/bullet/types/pungiglione_bullet.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class PungiglioneAvvelenatoAbilita extends Component implements AbilitiesActionService {
  final rng = Random();
  final BaseTower tower;

  double frequenza = 0.8;
  double probabilita = 0.2;

  late Timer _frequenzaTimer;
  bool _frequenzaRunning = false;

  PungiglioneAvvelenatoAbilita({required this.tower})
  {
    _frequenzaTimer = Timer(frequenza, repeat: true, onTick: probabilita_tela);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final hasTarget = tower.target != null && !tower.target!.isRemoved;

    // Avvia il timer solo se c'è un target e non siamo in cooldown
    if (hasTarget && !_frequenzaRunning) {
      _frequenzaTimer.start();
      _frequenzaRunning = true;
    }

    // Ferma il timer se non c’è più un target
    if (!hasTarget && _frequenzaRunning) {
      _frequenzaTimer.stop();
      _frequenzaRunning = false;
    }

    if (_frequenzaRunning) {
      _frequenzaTimer.update(dt);
    }
  }

  void probabilita_tela() {
    final target = tower.target;
    if (target == null || target.isRemoved) return;

    final p = rng.nextDouble();
    if (p < probabilita) {
      ability();
      _frequenzaTimer.stop();  // ferma temporaneamente il check
      _frequenzaRunning = false;
    }
  }

  @override
  void ability() {
    tower.parent?.add(PungiglioneBullet(tower: tower, target: tower.target!, damage: tower.damage+10));
  }

  void stop() {
    _frequenzaTimer.stop();
    _frequenzaRunning = false;
  }
}