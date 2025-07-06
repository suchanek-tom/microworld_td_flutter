import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/menu/select_menu/level_progress.dart';
import 'package:microworld_td/systems/level_manager.dart';

class GameState {
  static int coins = 250;
  static int lives = 5;
  static bool isGameOver = false;
  static bool isGameWon = false;
  static int waveNumber = 0;
  static int maxWaves = 0;
  static double new_wave_timer = 15.0;
  static int enemiesRemaining = 0;
  static  bool waveOnGoing = false;

  static void addCoins(int amount) {
    coins += amount;
  }

  static void initializeGame()
  {
    maxWaves = LevelManager.currentLevelInstance.waveConfiglevel.length;
  }

  static void startGame() 
  {
    if(waveOnGoing != true)
    {
      GameState.nextWave();
      EnemySpawner.startWithNoWaveTimer = true;
    }
  }

  static void loseLife() {
    enemiesRemaining>= 0 ? enemiesRemaining--: enemiesRemaining;
    lives--;
    if (lives <= 0) {
      gameOver();
    }
  }

  static void gameOver() {
    isGameOver = true;
  }

  static void winGame() {
    isGameWon = true;
  }

  static void nextWave() 
  {
    waveNumber < maxWaves ? waveNumber++ : waveNumber;
  }

  static void completeLevel() {
    if (!isGameWon) {
      winGame();
      final nextLevel = LevelManager.current_level + 1;
      LevelProgress.setUnlockedLevel(nextLevel);
    }
  }

  static void reset() {
    coins = 250;
    lives = 5;
    isGameOver = false;
    isGameWon = false;
    waveNumber = 0;
    new_wave_timer = 15.0;
    enemiesRemaining = 0;
  }
}
