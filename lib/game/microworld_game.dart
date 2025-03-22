import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/enemy/enemy_spawner.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/pathComponent.dart';
import 'package:microworld_td/game/components/towers/types/sniper_ant_tower.dart';
import 'package:microworld_td/game/components/towers/types/sticky_web_tower.dart';
import 'package:microworld_td/game/components/towers/types/venom_sprayer_tower.dart';

class MicroworldGame extends FlameGame {
  late TextComponent coinText;

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

    add(SniperAntTower(position: Vector2(550, 200)));
    add(VenomSprayerTower(position: Vector2(250, 400)));
    add(StickyWebTower(position: Vector2(170, 500)));

    add(EnemySpawner(
      waypoints: waypoints,
      spawnInterval: 2,
      enemiesToSpawn: 25,
    ));

    coinText = TextComponent(
      text: "Coins: ${GameState.coins}",
      position: Vector2(650, 20),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(coinText);

    debugPrint("Microworld TD Game Loaded!");
  }

  @override
  void update(double dt) {
    super.update(dt);
    coinText.text = "Coins: ${GameState.coins}";
  }
}
