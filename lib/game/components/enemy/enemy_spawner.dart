import 'package:flame/components.dart';
import  'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

enum WaveState {
  forceStartWave, // Prima di avviare la prima wave
  preWaveTimer, // Timer tra una wave e l'altra
  waveInProgress, // La wave è in corso e i nemici vengono spawnati
  waveCompleted, // Tutti i nemici sono stati spawnati per questa wave (ma potrebbero essercene ancora in campo)
}

class EnemySpawner extends Component{
  final List<Vector2> waypoints;
  final double spawnInterval;
  late double _spawnTimer; 
  int _enemiesToSpawnThisWave; 
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
        _enemiesToSpawnThisWave = 0; // Inizializza non statici nel costruttore

 @override
  void update(double dt) 
  {
    super.update(dt);

    if (GameState.isGameOver || GameState.isGameWon) {
      return;
    }

    switch (_currentWaveState) 
    {
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

        GameState.new_wave_timer > 0 ? GameState.new_wave_timer -= dt: GameState.new_wave_timer = 0;
        if(GameState.new_wave_timer == 0){
          _startNextWaveLogic();
        }
       
      break;

      case WaveState.waveInProgress:
        _spawnTimer += dt;
        if (_spawnTimer >= spawnInterval && _enemiesToSpawnThisWave > 0) {
          _spawnTimer = 0;
          _spawnNextEnemy();
        }

        if (_enemiesToSpawnThisWave == 0) {
          _currentWaveState = WaveState.waveCompleted;
        }
        break;

        case WaveState.waveCompleted:
        // Aspetta che tutti i nemici spawnati siano stati eliminati
        if (GameState.enemiesRemaining == 0) {
          // Tutte le ondate sono state completate
          if (GameState.waveNumber > GameState.maxWaves) {
            GameState.winGame();
          } else {
            // Avvia il timer per la prossima wave
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
    } else {
      GameState.winGame();
    }
  }

  // Chiamato quando si vuole avviare una nuova ondata (dopo il timer o forzatamente)
  void _startNewWave() {
    _currentWaveState = WaveState.waveInProgress;
    GameState.waveOnGoing = true; 
    GameState.new_wave_timer = 0; 
    GameState.nextWave();
    
    _enemiesToSpawnThisWave = 0; 
    GameState.enemiesRemaining = 0; 

    final currentWaveConfig = waveConfig[GameState.waveNumber];
    if (currentWaveConfig != null) {
      for (var enemyGroup in currentWaveConfig) {
        _enemiesToSpawnThisWave += enemyGroup['count'] as int;
      }
      GameState.enemiesRemaining = _enemiesToSpawnThisWave; 
    } else {
      print("Avviso: Nessuna configurazione trovata per onda ${GameState.waveNumber}. Usando fallback.");
      _enemiesToSpawnThisWave = 5 + (GameState.waveNumber * 2);
      GameState.enemiesRemaining = _enemiesToSpawnThisWave;
    }
  }

  // Chiamato quando un nemico deve essere spawnato
  void _spawnNextEnemy() {
    final List<Map<String, dynamic>>? currentWave = waveConfig[GameState.waveNumber];

    if (currentWave != null && _enemiesToSpawnThisWave > 0) {
      // Trova il prossimo tipo di nemico da spawnare
      for (int i = 0; i < currentWave.length; i++) {
        var enemyGroup = currentWave[i];
        if ((enemyGroup['count'] as int) > 0) {
          _spawnEnemy(enemyGroup['type']);
          // Decrementa il conteggio per questo gruppo di nemici all'interno della wave config
          enemyGroup['count'] = (enemyGroup['count'] as int) - 1;
          _enemiesToSpawnThisWave--; // Decrementa il contatore totale per la wave
          return; // Spawna un solo nemico per volta
        }
      }
    } else if (_enemiesToSpawnThisWave > 0) { 
        _spawnEnemy(WorkerAnt); 
        _enemiesToSpawnThisWave--;
    }
  }

  // Metodo helper per creare e aggiungere il nemico
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
        print("Errore: Tipo di nemico sconosciuto: $enemyType");
        return;
    }
    game.add(enemy as Component);
  }
}
