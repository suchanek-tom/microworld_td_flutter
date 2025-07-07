import 'dart:math';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:microworld_td/game/components/bullet/types/miele_bullet.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class MieleAbilita extends Component implements AbilitiesActionService
{
  int max_miele_percorso = 4;

  final rng = Random();
  final BaseTower tower;
  double duration = 45;
  static List<MieleBullet> pozzaMiele = [];

  double frequenza = 0.5;
  double cooldown = 10; // tempo di blocco dopo attivazione
  double probabilita = 0.1;

  late Timer _frequenzaTimer;
  late Timer _cooldownTimer;
  bool _frequenzaRunning = false;
  bool _onCooldown = false;

  @override
  String ability_name;

  MieleAbilita({required this.ability_name, required this.tower})
  {
      _frequenzaTimer = Timer(
        frequenza, 
        repeat: true, 
        onTick: probabilita_miele);

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
    final pozza = (MieleBullet(tower: tower, target: tower.target!, damage: 0, duration: duration,onDestroy: (self) {
      pozzaMiele.remove(self);
      }));
    
    pozzaMiele.add(pozza);
    tower.parent?.add(pozza);
  }

  void probabilita_miele()
  {
    final p = rng.nextDouble();
    if (p < probabilita && pozzaMiele.length <= max_miele_percorso)
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


  

