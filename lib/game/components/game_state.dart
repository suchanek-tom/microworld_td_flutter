class GameState {
  static int coins = 0;
  static int lives = 5;
  static bool isGameOver = false;

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
}
