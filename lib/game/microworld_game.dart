import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart' as flame;
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

class MicroworldGame extends FlameGame
    with flame.TapCallbacks, flame.PointerMoveCallbacks {
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;
  bool isFastForward = false;
  bool isGamePaused = false;

  TextComponent? gameOverText;
  TextComponent? winText;

  final GamePlay gamePlay = GamePlay();

  @override
  Future<void> onLoad() async {
    add(gamePlay);
    overlays.add("gameOverlay");
  }

  @override
void update(double dt) {
  super.update(dt);

  if (GameState.isGameOver && gameOverText == null) {
    gameOverText = TextComponent(
      text: "GAME OVER!",
      position: size / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
          shadows: [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 4,
              color: Colors.black87,
            ),
          ],
        ),
      ),
      priority: 100,
      scale: Vector2.all(0), // pro animaci
    );

    add(gameOverText!);

    gameOverText!.add(
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(
          duration: 0.6,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), pauseEngine);
  }

  if (GameState.isGameWon && winText == null) {
    winText = TextComponent(
      text: "YOU WIN!",
      position: size / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.green,
          shadows: [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 4,
              color: Colors.black87,
            ),
          ],
        ),
      ),
      priority: 100,
      scale: Vector2.all(0), // animace
    );

    add(winText!);

    winText!.add(
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(
          duration: 0.6,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), pauseEngine);
  }
}


  @override
  void onPointerMove(flame.PointerMoveEvent event) {
    if (gamePlay.isPlacingTower && gamePlay.towerBeingPlaced != null) {
      final mousePosition = event.localPosition;
      gamePlay.towerBeingPlaced!.position = mousePosition;
    }
    super.onPointerMove(event);
  }

  @override
  void onTapDown(flame.TapDownEvent event) {
    if (gamePlay.isPlacingTower) {
      gamePlay.isPlacingTower = false;
      gamePlay.towerBeingPlaced?.setPos = event.localPosition;
      gamePlay.towerBeingPlaced!.inplacement = false;
      gamePlay.towerBeingPlaced = null;
    }
    super.onTapDown(event);
  }
}
