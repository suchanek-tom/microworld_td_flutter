class GameState 
{
  static int coins = 150;
  static int lives = 5;
  static bool isGameOver = false;
  static bool isGameWon = false;
  static int waveNumber = 0;
  
  static void addCoins(int amount) {
    coins += amount;
  }

  static void loseLife(){
    lives --;
    if(lives <= 0){
      gameOver();
    }
  }

  static void gameOver() {
    isGameOver = true;
  }

  static void winGame() {
    isGameWon = true;
  }
  
   static void nextWave() {
    waveNumber++;
  }
}
