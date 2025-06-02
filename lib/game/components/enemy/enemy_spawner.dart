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
  double spawnInterval;
  final GamePlay game;

  double _timer = 0.0;
  int _enemiesToSpawn = 0;
  int _enemiesRemaining = 0;
  int _spawnIndex = 0;
  List<_EnemyBatch> _currentWaveEnemies = [];

  EnemySpawner({
    required this.waypoints,
    required this.spawnInterval,
    required this.game,
  });

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

    if (_enemiesToSpawn <= 0 && _enemiesRemaining == 0) {
      if (GameState.waveNumber >= 10) {
        GameState.winGame();
        return;
      }

      GameState.waveNumber++;
      _startNewWave();
    }

    _timer += dt;
    if (_timer >= spawnInterval && _enemiesToSpawn > 0) {
      _timer = 0;
      _spawnNextEnemy();
    }
  }

  void _startNewWave() {
    _timer = 0;
    _spawnIndex = 0;
    _enemiesToSpawn = 0;
    _currentWaveEnemies.clear();

    final config = waveConfig[GameState.waveNumber];
    if (config != null) {
      _currentWaveEnemies = config.map((e) => e.copy()).toList();
      _enemiesToSpawn = _currentWaveEnemies.fold(0, (sum, batch) => sum + batch.count);
    } else {
      // Default wave if not defined
      final fallbackCount = 5 + (GameState.waveNumber * 2);
      _currentWaveEnemies.add(_EnemyBatch(WorkerAnt, fallbackCount));
      _enemiesToSpawn = fallbackCount;
    }
  }

  void _spawnNextEnemy() {
    for (var batch in _currentWaveEnemies) {
      if (batch.count > 0) {
        _spawnEnemy(batch.type);
        batch.count--;
        _enemiesToSpawn--;
        _enemiesRemaining++;
        return;
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

    enemy?.onDeath = () => _enemiesRemaining--;
    game.add(enemy!);
  }
}

class _EnemyBatch {
  final Type type;
  int count;

  _EnemyBatch(this.type, this.count);

  _EnemyBatch copy() => _EnemyBatch(type, count);
}
