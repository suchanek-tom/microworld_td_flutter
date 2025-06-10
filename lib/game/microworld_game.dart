import 'package:flame/components.dart';
import 'package:flame/flame.dart';
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

  void resumeGame() {
    overlays.remove('PauseMenu');
    resumeEngine();
  }

  @override
  Future<void> onLoad() async 
  {

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
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Colors.red,
          ),
        ),
        priority: 100,
      );
      add(gameOverText!);
      Future.delayed(const Duration(seconds: 1), pauseEngine);
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
      Future.delayed(const Duration(seconds: 1), pauseEngine);
    }
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
