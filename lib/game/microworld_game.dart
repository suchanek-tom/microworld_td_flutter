import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';
import 'package:microworld_td/game/components/towers/types/sniper_ant_tower.dart';
import 'package:microworld_td/levels/level.dart';
import 'package:microworld_td/ui/towerPanelComponent.dart';
import 'package:flame/extensions.dart';


class MicroworldGame extends FlameGame with TapDetector 
{
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;
  late final CameraComponent cam;

  late var level = Level();

  TextComponent? gameOverText;
  TextComponent? winText;
  String? selectedTowerType;
  bool removeMode = false;

  late EnemySpawner enemySpawner;

  @override
  Future<void> onLoad() async 
  {
    // cam = CameraComponent.withFixedResolution(world: level, width: 1280, height: 768);
    // cam.viewfinder.anchor = Anchor.topLeft;

    // add(cam);
    // add(level);
  
     add(RectangleComponent(
      size: Vector2(1280, 768),
      paint: Paint()..color = const Color(0xFFC8E6C9),
      priority: -10,
    ));

    add(TowerPanelComponent());
   
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

    enemySpawner = EnemySpawner(
      waypoints: waypoints,
      spawnInterval: 2,
    );
    add(enemySpawner);

    add(BeeTower(position: Vector2(300, 250)));
    add(BeeTower(position: Vector2(300, 350)));

    // UI components
    coinText = TextComponent(
      text: "Coins: ${GameState.coins}",
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

    livesText = TextComponent(
      text: "Lives: ${GameState.lives}",
      position: Vector2(10, 40),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

    waveText = TextComponent(
      text: "Wave: ${GameState.waveNumber}",
      position: Vector2(size.x / 2, 10),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

    add(coinText);
    add(livesText);
    add(waveText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    coinText.text = "Coins: ${GameState.coins}";
    livesText.text = "Lives: ${GameState.lives}";
    waveText.text = "Wave: ${GameState.waveNumber}";

    if (GameState.isGameOver && gameOverText == null) {
      gameOverText = TextComponent(
        text: "GAME OVER!",
        position: Vector2(size.x / 2, 50),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Colors.red,
          ),
        ),
        priority: 100,
      );
      add(gameOverText!);
      Future.delayed(const Duration(seconds: 1), () {
        pauseEngine();
      });
    } else if (GameState.isGameWon && winText == null) {
      winText = TextComponent(
        text: "YOU WIN!",
        position: Vector2(size.x / 2, 50),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        priority: 100,
      );
      add(winText!);
      Future.delayed(const Duration(seconds: 1), () {
        pauseEngine();
      });
    }
  }

}
