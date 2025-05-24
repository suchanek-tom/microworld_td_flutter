import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart' as flame;
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/gameplay.dart';

class MicroworldGame extends FlameGame with flame.TapCallbacks,flame.PointerMoveCallbacks
{
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;

  TextComponent? gameOverText;
  TextComponent? winText;

  final GamePlay gamePlay = GamePlay();

  @override
  Future<void> onLoad() async 
  {
    
    //WE NEED TO DO THE GAMELOOP
    add(gamePlay);
    overlays.add("gameOverlay"); 
   
  }

  @override
  void update(double dt) {
    super.update(dt);

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

  @override
  void onPointerMove(flame.PointerMoveEvent event) 
  {
    if (gamePlay.isPlacingTower && gamePlay.towerBeingPlaced != null) 
    {
      print("entri????");
      final mousePosition = event.localPosition;
      gamePlay.towerBeingPlaced!.position = mousePosition;
    }
    super.onPointerMove(event);
  }

  @override
  void onTapDown(flame.TapDownEvent event) 
  {
    print("lezzo");
    if (gamePlay.isPlacingTower) 
    {
       gamePlay.isPlacingTower = false;
       gamePlay.towerBeingPlaced = null;
       gamePlay.towerBeingPlaced?.setPos = event.localPosition;
       add(gamePlay.towerBeingPlaced!);
    }
    super.onTapDown(event);
  }
}
