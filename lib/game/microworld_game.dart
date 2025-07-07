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

class MicroworldGame extends FlameGame with flame.TapCallbacks, flame.PointerMoveCallbacks {
  late TextComponent livesText;
  late TextComponent coinText;
  late TextComponent waveText;

  GamePlay gamePlay = GamePlay();
  late final TowerUpgradeSystem upgradeSystem;

  final Map<String, Widget> overlayInstances = {};
  final int currentLevel;
  MicroworldGame({required this.currentLevel});

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

  void resetGame() {
  GameState.reset();

  gamePlay.removeFromParent();
  gamePlay = GamePlay();
  add(gamePlay);
  overlays.clear();
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

    if (GameState.isGameOver && !overlays.isActive('GameOverMenu')) {
      pauseEngine();
      overlays.add('GameOverMenu');
    }

    if (GameState.isGameWon && !overlays.isActive('GameWinMenu')) {
      pauseEngine();
      overlays.add('GameWinMenu');

      GameState.completeLevel();
    }
  }

  @override
  void onPointerMove(flame.PointerMoveEvent event) {
    if (gamePlay.isPlacingTower && gamePlay.towerBeingPlaced != null) {
      final mousePosition = event.localPosition;
      gamePlay.towerBeingPlaced!.position = mousePosition;
      gamePlay.towerBeingPlaced!.showRange(true);
    }
    super.onPointerMove(event);
  }

  @override
  void onTapDown(flame.TapDownEvent event) {
    final localPos = gamePlay.cam.globalToLocal(event.canvasPosition);

    if (gamePlay.isPlacingTower) {
      gamePlay.isPlacingTower = false;
      gamePlay.towerBeingPlaced!.showRange(false);
      gamePlay.towerBeingPlaced?.setPos = localPos;
      gamePlay.towerBeingPlaced!.inplacement = false;
      gamePlay.towerBeingPlaced = null;
    } else {
      final tappedTower = gamePlay.children
          .whereType<BaseTower>()
          .firstWhereOrNull((tower) => tower.toRect().contains(localPos.toOffset()));

      if (tappedTower != null) {
        gamePlay.isSelectingTower = true;
        upgradeSystem.openUpgradePanel(tappedTower);

        for (final tower in gamePlay.children.whereType<BaseTower>()) {
          tower.showRange(tower == tappedTower);
        }
      } else {
        gamePlay.isSelectingTower = false;
        upgradeSystem.closeUpgradePanel();

        for (final tower in gamePlay.children.whereType<BaseTower>()) {
          tower.showRange(false);
        }
      }
    }
    super.onTapDown(event);
  }
}
