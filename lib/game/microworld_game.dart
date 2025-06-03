import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart' as flame;
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:collection/collection.dart';
import 'package:flame/extensions.dart';
import 'package:microworld_td/systems/tower_upgrade.dart';
import 'package:microworld_td/ui/tower_panel_component.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';

class MicroworldGame extends FlameGame with flame.TapCallbacks, flame.PointerMoveCallbacks 
{
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;

  bool isFastForward = false;
  bool isGamePaused = false;

  TextComponent? gameOverText;
  TextComponent? winText;

  final GamePlay gamePlay = GamePlay();
  late final TowerUpgradeSystem upgradeSystem; 
  final Map<String, Widget> overlayInstances = {};
  
  late GlobalKey<TowerPanelUpgradeComponentState> upgradepanelKeystate;
  late GlobalKey<TowerPanelComponentState> towerpanelKeystate;

  //todo: add pause_menu screen
  void pauseGame() {
    pauseEngine();
    overlays.add('PauseMenu');
  }

  set timeScale(double timeScale) {}

  @override
  Future<void> onLoad() async 
  {
    add(gamePlay);
    overlays.add("TowerPanel");
    overlays.add("TowerPanelUpgrade");
  }

  void initializeUpgradeSystem() {
    upgradeSystem = TowerUpgradeSystem(panelKey: upgradepanelKeystate);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (GameState.isGameOver && gameOverText == null) {
      showGameOverText();
    }

    if (GameState.isGameWon && winText == null) {
      showWinText();
    }
  }

  void showGameOverText() {
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
      scale: Vector2.all(0),
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

  void showWinText() {
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
      scale: Vector2.all(0),
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

  void toggleFastForward() {
    isFastForward = !isFastForward;
    gamePlay.toggleFastForward();
  }

  @override
  void onPointerMove(flame.PointerMoveEvent event) 
  {
    if (gamePlay.isPlacingTower && gamePlay.towerBeingPlaced != null) {
      final mousePosition = event.localPosition;
      gamePlay.towerBeingPlaced!.position = mousePosition;
    }
    super.onPointerMove(event);
  }

  @override
  void onTapDown(flame.TapDownEvent event) 
  {
    final localPos = gamePlay.cam.globalToLocal(event.canvasPosition);

    if (gamePlay.isPlacingTower) 
    {
      gamePlay.isPlacingTower = false;
      gamePlay.towerBeingPlaced?.setPos = event.localPosition;
      gamePlay.towerBeingPlaced!.inplacement = false;
      gamePlay.towerBeingPlaced = null;
    }
    else
    {
      //Verifica se hai cliccato su una torre esistente
      final tappedTower = gamePlay.children
        .whereType<BaseTower>()
        .firstWhereOrNull((tower) => tower.toRect().contains(localPos.toOffset()));

      if (tappedTower != null)
      {
        gamePlay.isSelectingTower = true;
        print('Hai selezionato la torre: ${tappedTower.towerName}');
        upgradeSystem.openUpgradePanel(tappedTower);
      }
      else
      {
        gamePlay.isSelectingTower = false;
        upgradeSystem.closeUpgradePanel();
      }
    }   
    super.onTapDown(event);
  }
}
