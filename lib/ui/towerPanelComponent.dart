import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';
import 'package:microworld_td/game/microworld_game.dart';

class TowerPanelComponent extends PositionComponent
    with HasGameRef<MicroworldGame> {
  final void Function(BaseTower Function(Vector2 position)) onTowerSelected;
  final flutter.VoidCallback onTowerPlaced;

  bool beeSelected = false;
  late RectangleComponent beeButtonBackground;

  TowerPanelComponent({
    required this.onTowerSelected,
    required this.onTowerPlaced,
  });

  @override
  Future<void> onLoad() async {
    size = Vector2(180, 600);
    position = Vector2(800 - 200, 0);

    add(
      RectangleComponent(
        size: size,
        paint: flutter.Paint()
          ..color = flutter.Colors.grey.shade900.withOpacity(0.6),
        priority: -1,
      ),
    );

    final buttonSize = Vector2(160, 50);
    final buttonPosition = Vector2(10, 20);

    beeButtonBackground = RectangleComponent(
      size: buttonSize,
      paint: flutter.Paint()
        ..color = flutter.Colors.grey.shade700.withOpacity(0.8),
    );

    final text = TextComponent(
      text: 'Bee Tower',
      position: buttonSize / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const flutter.TextStyle(
          fontSize: 16,
          color: flutter.Colors.white,
          fontWeight: flutter.FontWeight.bold,
        ),
      ),
    );

    final beeButton = ButtonComponent(
      position: buttonPosition,
      size: buttonSize,
      button: beeButtonBackground,
      buttonDown: RectangleComponent(
        size: buttonSize,
        paint: flutter.Paint()
          ..color = flutter.Colors.grey.shade800.withOpacity(0.9),
      ),
      children: [text],
      onPressed: () {
        if (!beeSelected) {
          beeSelected = true;
          _updateBeeButtonColor();
          onTowerSelected((pos) => BeeTower(position: pos));
        }
      },
    );

    add(beeButton);
  }

  void resetSelection() {
    beeSelected = false;
    _updateBeeButtonColor();
  }

  void _updateBeeButtonColor() {
    beeButtonBackground.paint.color = beeSelected
        ? flutter.Colors.grey.shade500.withOpacity(0.9)
        : flutter.Colors.grey.shade700.withOpacity(0.8);
  }
}
