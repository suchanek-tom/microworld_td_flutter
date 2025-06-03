import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queens_guard.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

class EnemySpawner extends Component {
  final List<Vector2> waypoints;
  final GamePlay game;
  final double spawnInterval;

  double _spawnTimer = 0.0;
  int _enemiesToSpawn = 0;
  int _enemiesRemaining = 0;
  List<_EnemyBatch> _currentWaveEnemies = [];

  EnemySpawner({
    required this.waypoints,
    required this.spawnInterval,
    required this.game,
  });

  /// Wave configuration: wave number → list of enemy types and their counts
  final Map<int, List<_EnemyBatch>> waveConfig = {
    1: [ _EnemyBatch(WorkerAnt, 5), _EnemyBatch(QueenAnt, 1) ],
    2: [ _EnemyBatch(WorkerAnt, 8) ],
    3: [ _EnemyBatch(WorkerAnt, 6), _EnemyBatch(TurboAnt, 2) ],
    4: [ _EnemyBatch(TurboAnt, 5) ],
    5: [ _EnemyBatch(WorkerAnt, 5), _EnemyBatch(ArmoredAnt, 2) ],
    6: [ _EnemyBatch(TurboAnt, 6), _EnemyBatch(ArmoredAnt, 2) ],
    7: [ _EnemyBatch(WorkerAnt, 4), _EnemyBatch(TurboAnt, 4), _EnemyBatch(ArmoredAnt, 3) ],
    8: [ _EnemyBatch(ArmoredAnt, 5) ],
    9: [ _EnemyBatch(WorkerAnt, 6), _EnemyBatch(TurboAnt, 6) ],
    10: [ _EnemyBatch(QueensGuard, 1), _EnemyBatch(ArmoredAnt, 3) ],
  };

  @override
  void update(double dt) {
    super.update(dt);

    // Pokud není co spawnovat a žádní nepřátelé nezůstali, začni další vlnu
    if (_enemiesToSpawn <= 0 && _enemiesRemaining <= 0) {
      if (GameState.waveNumber >= waveConfig.length) {
        GameState.winGame();
        return;
      }

      GameState.waveNumber++;
      _startNewWave();
    }

    // Časovač pro spawn jednotlivých nepřátel
    _spawnTimer += dt;
    if (_spawnTimer >= spawnInterval && _enemiesToSpawn > 0) {
      _spawnTimer = 0;
      _spawnNextEnemy();
    }
  }

  void _startNewWave() {
    _spawnTimer = 0;
    _enemiesToSpawn = 0;
    _currentWaveEnemies.clear();

    final config = waveConfig[GameState.waveNumber];
    if (config != null) {
      _currentWaveEnemies = config.map((batch) => batch.copy()).toList();
    } else {
      // Fallback pro vyšší vlny
      final fallbackCount = 5 + (GameState.waveNumber * 2);
      _currentWaveEnemies = [ _EnemyBatch(WorkerAnt, fallbackCount) ];
    }

    _enemiesToSpawn = _currentWaveEnemies.fold(0, (sum, batch) => sum + batch.count);
  }

  void _spawnNextEnemy() {
    for (final batch in _currentWaveEnemies) {
      if (batch.count > 0) {
        _spawnEnemy(batch.type);
        batch.count--;
        _enemiesToSpawn--;
        _enemiesRemaining++;
        break;
      }
    }
  }

  void _spawnEnemy(Type type) {
    BaseEnemy? enemy;

    switch (type) {
      case WorkerAnt:
        enemy = WorkerAnt(waypoints: waypoints);
        break;
      case ArmoredAnt:
        enemy = ArmoredAnt(waypoints: waypoints);
        break;
      case TurboAnt:
        enemy = TurboAnt(waypoints: waypoints);
        break;
      case QueensGuard:
        enemy = QueensGuard(waypoints: waypoints);
        break;
      case QueenAnt:
        enemy = QueenAnt(waypoints: waypoints);
        break;
      default:
        return;
    }

    enemy.onDeath = () {
      _enemiesRemaining--;
    };

    game.add(enemy);
  }
}

class _EnemyBatch {
  final Type type;
  int count;

  _EnemyBatch(this.type, this.count);

  _EnemyBatch copy() => _EnemyBatch(type, count);
}
