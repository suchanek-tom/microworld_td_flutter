import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart' as flame;
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:collection/collection.dart';
import 'package:microworld_td/systems/tower_upgrade.dart';
import 'package:microworld_td/ui/tower_panel_component.dart';
import 'package:microworld_td/ui/tower_panel_upgrade_component.dart';

class MicroworldGame extends FlameGame
    with flame.TapCallbacks, flame.PointerMoveCallbacks {
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;

  TextComponent? gameOverText;
  TextComponent? winText;

  GamePlay gamePlay = GamePlay();
  late final TowerUpgradeSystem upgradeSystem;
  final Map<String, Widget> overlayInstances = {};

  late GlobalKey<TowerPanelUpgradeComponentState> upgradepanelKeystate;
  late GlobalKey<TowerPanelComponentState> towerpanelKeystate;

  void pauseGame() {
    pauseEngine();
    overlays.add('PauseMenuPanel');
  }

  void resumeGame() {
    overlays.remove('PauseMenuPanel');
    resumeEngine();
  }

  void reset() async {
  overlays.remove('TowerPanel');
  overlays.remove('TowerPanelUpgrade');
  overlays.remove('PauseMenuPanel');

  GameState.reset();

  gamePlay.removeFromParent();

  final newGamePlay = GamePlay();
  add(newGamePlay);

  gamePlay = newGamePlay;

  overlays.add("TowerPanel");
  overlays.add("TowerPanelUpgrade");

  resumeEngine();
}



  @override
  Future<void> onLoad() async {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();

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
      gameOverText = TextComponent(
        text: "GAME OVER!",
        position: Vector2(size.x / 2, 50),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.red,
          ),
        ),
        priority: 100,
      );
      add(gameOverText!);
      Future.delayed(const Duration(seconds: 1), pauseGame);
    } else if (GameState.isGameWon && winText == null) {
      GameState.completeLevel();
      winText = TextComponent(
        text: "YOU WIN!",
        position: Vector2(size.x / 2, 50),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        priority: 100,
      );
      add(winText!);
      Future.delayed(const Duration(seconds: 1), pauseGame);
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
  final localPos = gamePlay.cam.globalToLocal(event.canvasPosition);

  if (gamePlay.isPlacingTower) {
    gamePlay.isPlacingTower = false;
    gamePlay.towerBeingPlaced?.setPos = localPos;
    gamePlay.towerBeingPlaced!.inplacement = false;
    gamePlay.towerBeingPlaced = null;
  } else {
    // Najdi věž, na kterou bylo kliknuto
    final tappedTower = gamePlay.children
        .whereType<BaseTower>()
        .firstWhereOrNull(
            (tower) => tower.toRect().contains(localPos.toOffset()));

    if (tappedTower != null) {
      gamePlay.isSelectingTower = true;
      upgradeSystem.openUpgradePanel(tappedTower);

      for (final tower in gamePlay.children.whereType<BaseTower>()) {
        tower.showRange(tower == tappedTower); // zobraz range jen u kliknuté věže
      }
    } else {
      // Klik mimo věž
      gamePlay.isSelectingTower = false;
      upgradeSystem.closeUpgradePanel();

      for (final tower in gamePlay.children.whereType<BaseTower>()) {
        tower.showRange(false); // skryj všechny range kruhy
      }
    }
  }

  super.onTapDown(event);
}

}
