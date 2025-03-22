class GameState {
  static int coins = 0;

  static void addCoins(int amount) {
    coins += amount;
    print("💰 Coins: $coins");
  }
}
