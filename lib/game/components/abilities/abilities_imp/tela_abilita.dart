import 'package:flame/components.dart';
import 'dart:math';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/bullet/types/web_bullet.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class TelaAbilita extends Component implements AbilitiesActionService {
  final rng = Random();
  final BaseTower tower;

  double moltiplicatore_danni = 0.8;
  int rallentamento = 1;
  double durata_effetto = 3;
  double cooldown = 2;
  double probabilita = 0.15;

  late Timer _timer;
  bool _timerRunning = false;

  TelaAbilita({required this.tower}) {
    _timer = Timer(cooldown, repeat: true, onTick: probabilita_tela);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final hasTarget = tower.target != null && !tower.target!.isRemoved;

    // Avvia il timer se c'è un target e il timer non sta già girando
    if (hasTarget && !_timerRunning) {
      _timer.start();
      _timerRunning = true;
    }

    // Ferma il timer se il target non c'è più e il timer è attivo
    if (!hasTarget && _timerRunning) {
      _timer.stop();
      _timerRunning = false;
    }

    // Esegui il timer solo se attivo
    if (_timerRunning) {
      _timer.update(dt);
    }

    print(_timer);
  }

  void probabilita_tela() {
    final target = tower.target;
    if (target == null || target.isRemoved) return;

    final p = rng.nextDouble();
    if (p < probabilita) {
      ability();
    }
  }

  @override
  void ability() {
    parent?.add(WebBullet(tower: tower, target: tower.target!, damage: 0));
    print("🕸️ Abilità attivata!");
  }

  void stop() {
    _timer.stop();
    _timerRunning = false;
  }
}
