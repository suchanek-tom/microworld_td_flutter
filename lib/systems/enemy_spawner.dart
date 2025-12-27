import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

enum WaveState {
  forceStartWave, 
  preWaveTimer, 
  waveInProgress, 
  waveCompleted, 
}

class EnemySpawner extends Component {
  final List<Vector2> waypoints;
  final double spawnInterval;
  late double _spawnTimer;
  int _enemiesToSpawnThisWave; // Rimane solo questo: il "serbatoio" di nemici da generare
  final GamePlay game;
  final Map<int, List<Map<String, dynamic>>> waveConfig;

  WaveState _currentWaveState = WaveState.preWaveTimer;

  static bool forceStartNextWave = false;

  EnemySpawner({
    required this.waypoints,
    required this.spawnInterval,
    required this.game,
    required this.waveConfig,
  })  : _spawnTimer = 0.0,
        _enemiesToSpawnThisWave = 0;

  // Questa funzione è la tua nuova "verità assoluta"
  int get activeEnemiesOnField {
    print(game.children.whereType<BaseEnemy>().length);
    return game.children.whereType<BaseEnemy>().length;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (GameState.isGameOver || GameState.isGameWon) {
      return;
    }

    // --- AGGIORNAMENTO UI (Opzionale) ---
    // Se hai una label a schermo, scommenta questa riga per aggiornarla.
    // Ma NON usiamo questa variabile per la logica degli if/switch sotto.
    // GameState.enemiesRemaining = _enemiesToSpawnThisWave + activeEnemiesOnField;
    // ------------------------------------

    switch (_currentWaveState) {
      case WaveState.forceStartWave:
        if (forceStartNextWave) {
          forceStartNextWave = false;
          _startNextWaveLogic();
        }
        break;

      case WaveState.preWaveTimer:
        if (forceStartNextWave) {
          _currentWaveState = WaveState.forceStartWave;
          break;
        }

        GameState.new_wave_timer > 0
            ? GameState.new_wave_timer -= dt
            : GameState.new_wave_timer = 0;
        
        if (GameState.new_wave_timer == 0) {
          _startNextWaveLogic();
        }
        break;

      case WaveState.waveInProgress:
        _spawnTimer += dt;
        
        // Spawna se è passato il tempo E se ci sono ancora nemici nel "serbatoio"
        if (_spawnTimer >= spawnInterval && _enemiesToSpawnThisWave > 0) {
          _spawnTimer = 0;
          _spawnNextEnemy();
        }

        // Se il "serbatoio" è vuoto, passiamo allo stato di attesa completamento
        if (_enemiesToSpawnThisWave <= 0) {
          _currentWaveState = WaveState.waveCompleted;
        }
        break;

      case WaveState.waveCompleted:
        // CONTROLLO REALE: Ci sono ancora formiche vive in giro?
        if (activeEnemiesOnField == 0) {
          
          // Se non ci sono formiche E ho finito le ondate -> VITTORIA
          if (GameState.waveNumber >= GameState.maxWaves) {
            GameState.winGame();
          } else {
            // Altrimenti -> Prossima Wave
            _currentWaveState = WaveState.preWaveTimer;
            GameState.new_wave_timer = 15;
            GameState.waveOnGoing = false;
          }
        }
        break;
    }
  }

  void _startNextWaveLogic() {
    if (GameState.waveNumber < GameState.maxWaves) {
      _startNewWave();
    }
  }

  void _startNewWave() {
    _currentWaveState = WaveState.waveInProgress;
    GameState.waveOnGoing = true;
    GameState.new_wave_timer = 0;
    GameState.nextWave();

    _enemiesToSpawnThisWave = 0; 
    // Nota: Ho rimosso l'azzeramento di GameState.enemiesRemaining perché non lo usiamo più.

    final currentWaveConfig = waveConfig[GameState.waveNumber];
    if (currentWaveConfig != null) {
      for (var enemyGroup in currentWaveConfig) {
        _enemiesToSpawnThisWave += enemyGroup['count'] as int;
      }
    } else {
      print("Avviso: Nessuna configurazione trovata per onda ${GameState.waveNumber}.");
      _enemiesToSpawnThisWave = 5 + (GameState.waveNumber * 2);
    }
  }

  void _spawnNextEnemy() {
    final List<Map<String, dynamic>>? currentWave = waveConfig[GameState.waveNumber];

    if (currentWave != null && _enemiesToSpawnThisWave > 0) {
      for (int i = 0; i < currentWave.length; i++) {
        var enemyGroup = currentWave[i];
        
        if ((enemyGroup['count'] as int) > 0) {
          _spawnEnemy(enemyGroup['type']);
          enemyGroup['count'] = (enemyGroup['count'] as int) - 1;
          _enemiesToSpawnThisWave--; // Decrementa solo il serbatoio locale
          return; 
        }
      }
    } else if (_enemiesToSpawnThisWave > 0) {
      _spawnEnemy(WorkerAnt);
      _enemiesToSpawnThisWave--;
    }
  }

  void _spawnEnemy(Type enemyType) {
    BaseEnemy? enemy;
    switch (enemyType) {
      case WorkerAnt:
        enemy = WorkerAnt(waypoints: waypoints);
        break;
      case ArmoredAnt:
        enemy = ArmoredAnt(waypoints: waypoints);
        break;
      case TurboAnt:
        enemy = TurboAnt(waypoints: waypoints);
        break;
      case QueenGuard:
        enemy = QueenGuard(waypoints: waypoints);
        break;
      case QueenAnt:
        enemy = QueenAnt(waypoints: waypoints);
        break;
      default:
        return;
    }
    game.add(enemy as Component);
  }
}