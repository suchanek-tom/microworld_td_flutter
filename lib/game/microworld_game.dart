import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/pathComponent.dart';

class MicroworldGame extends FlameGame {
  late TextComponent livesText;
  late TextComponent coinText;
  TextComponent? gameOverText;

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFFC8E6C9),
    ));

    List<Vector2> waypoints = [
      Vector2(50, 500),
      Vector2(150, 500),
      Vector2(150, 400),
      Vector2(250, 400),
      Vector2(250, 300),
      Vector2(400, 300),
      Vector2(550, 350),
      Vector2(700, 300),
    ];

    add(PathComponent(waypoints: waypoints));

    add(EnemySpawner(
      waypoints: waypoints,
      spawnInterval: 2,
      enemiesToSpawn: 25,
    ));

    coinText = TextComponent(
      text: 'Coins: \${GameState.coins}',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

    livesText = TextComponent(
      text: 'Lives: \${GameState.lives}',
      position: Vector2(10, 40),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

    add(coinText);
    add(livesText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    coinText.text = 'Coins: \${GameState.coins}';
    livesText.text = 'Lives: \${GameState.lives}';

    if (GameState.isGameOver) {
      if (gameOverText == null) {
        gameOverText = TextComponent(
          text: "GAME OVER!",
          position: size / 2,
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 50, 
              fontWeight: FontWeight.bold, 
              color: Colors.red,
            ),
          ),
          priority: 100, 
        );
        add(gameOverText!);

        Future.delayed(Duration(milliseconds: 100), () {
          pauseEngine();
        });
      }
    }
  }
}
