import 'package:flame/components.dart';
import 'package:microworld_td/game/components/enemy/baseEnemy.dart';
import 'package:microworld_td/game/components/enemy/types/armored_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_ant.dart';
import 'package:microworld_td/game/components/enemy/types/turbo_ant.dart';
import 'package:microworld_td/game/components/enemy/types/queen_guard.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

class EnemySpawner extends Component 
{
  final List<Vector2> waypoints;
  final double spawnInterval;
  double timer = 0.0;
  static int enemiesToSpawn = 0;
  final GamePlay game;
  static bool startWithNoWaveTimer = false;
  Map<int, List<Map<String, dynamic>>> waveConfig;
 
  EnemySpawner(
    {
      required this.waypoints, 
      required this.spawnInterval,
      required this.game,
      required this.waveConfig,
    });

  @override
  void update(double dt) 
  {
    super.update(dt);

    if (enemiesToSpawn == 0 && GameState.enemiesRemaining == 0) 
    {
      
      if(game.waveOnGoing == true) {
        
        GameState.new_wave_timer = 15.0;
        game.waveOnGoing = false;
      }

       if(GameState.new_wave_timer == 0) {
        GameState.waveNumber++;
        game.waveOnGoing = true;
        startNewWave();
      }

      if(startWithNoWaveTimer == true){
        startNewWave();
        startWithNoWaveTimer = false;
        game.waveOnGoing = true;
      }

      GameState.new_wave_timer > 0 ? GameState.new_wave_timer -= dt: GameState.new_wave_timer = 0;

      if (GameState.waveNumber >= 10) {
        GameState.winGame(); 
        return;
      }
    }

    timer += dt;
    if (timer >= spawnInterval && enemiesToSpawn > 0) {
      timer = 0;
      spawnNextEnemy();
    }
  }

  void startNewWave() 
  {
    enemiesToSpawn = 0;
    GameState.new_wave_timer = 0;

    if (waveConfig.containsKey(GameState.waveNumber)) {
      for (var enemyGroup in waveConfig[GameState.waveNumber]!) {
        enemiesToSpawn += enemyGroup['count'] as int;
      }
    } else {
      enemiesToSpawn = 5 + (GameState.waveNumber * 2); 
    }
    GameState.enemiesRemaining = enemiesToSpawn;
  }

  void spawnNextEnemy() {
    final List<Map<String, dynamic>>? currentWave = waveConfig[GameState.waveNumber];

    if (currentWave != null) {
      for (var enemyGroup in currentWave) {
        if ((enemyGroup['count'] as int) > 0) {
          spawnEnemy(enemyGroup['type']);
          enemyGroup['count'] = (enemyGroup['count'] as int) - 1;
          enemiesToSpawn--;
          return;
        }
      }
    }
  }

  void spawnEnemy(Type enemyType) {
  BaseEnemy? enemy;

  switch (enemyType)
  {
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
    }
  
    game.add(enemy as Component);
  }
}
