import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microworld_td/systems/enemy_spawner.dart';
import 'package:microworld_td/game/components/enemy/types/worker_ant.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

class MockGamePlay extends GamePlay {
  final List<Component> addedComponents = [];

  MockGamePlay() : super();

  @override
  void add(Component component) {
    addedComponents.add(component);
  }
}

void main() {

  group('EnemySpawner basic tests', () 
  {
    late MockGamePlay mockGame;
    late EnemySpawner spawner;
    late List<Vector2> waypoints;

    setUp(() {
      mockGame = MockGamePlay();
      waypoints = [Vector2.zero(), Vector2(10, 0)];
      GameState.waveNumber = 1;
      GameState.maxWaves = 5;
      GameState.new_wave_timer = 1;
      GameState.enemiesRemaining = 0;
      GameState.waveOnGoing = false;
      GameState.isGameOver = false;
      GameState.isGameWon = false;

      spawner = EnemySpawner(
        waypoints: waypoints,
        spawnInterval: 0.1,
        game: mockGame,
        waveConfig: {
          1: [
            {'type': WorkerAnt, 'count': 2},
          ],
        },
      );
    });

    test('From preWaveTimer to waveInProgress and spawning enemies', () {
      // Stato iniziale: preWaveTimer
      expect(GameState.waveOnGoing, isFalse);

      // Timer ancora non scaduto
      spawner.update(0.5);
      expect(GameState.waveOnGoing, isFalse);
      expect(GameState.new_wave_timer, closeTo(0.5, 0.01));

      // Timer scade e inizia nuova wave
      spawner.update(0.5); // totale 1.0
      expect(GameState.waveOnGoing, isTrue);

      // Nessun nemico ancora spawnato
      expect(mockGame.addedComponents.length, 0);

      // Dopo spawnInterval viene spawnato il primo nemico
      spawner.update(0.1);
      expect(mockGame.addedComponents.length, 1);
      expect(mockGame.addedComponents[0], isA<WorkerAnt>());
    });

    test('Fallback spawning if waveConfig missing', () {
      spawner = EnemySpawner(
        waypoints: waypoints,
        spawnInterval: 0.1,
        game: mockGame,
        waveConfig: {}, // Nessuna configurazione
      );
      GameState.waveNumber = 1;
      GameState.new_wave_timer = 0;

      // Forza nuova wave
      spawner.update(0.1);
      expect(GameState.waveOnGoing, isTrue);

      // Spawna nemico fallback (WorkerAnt)
      spawner.update(0.1);
      expect(mockGame.addedComponents[0], isA<WorkerAnt>());
    });
  });
}