import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';

class TowerPanelComponent extends PositionComponent with HasGameRef {
  final void Function(BaseTower Function(Vector2 position)) onTowerSelected;

  TowerPanelComponent({required this.onTowerSelected});

  @override
  Future<void> onLoad() async {
    size = Vector2(180, 600);
    position = Vector2(800 - 180, 0);

    add(
      RectangleComponent(
        size: size,
        paint: flutter.Paint()..color = flutter.Colors.black.withOpacity(0.5),
        priority: -1,
      ),
    );

    final towers = <String, BaseTower Function(Vector2)>{
      'Bee': (Vector2 pos) => BeeTower(position: pos),
    };

    int index = 0;
    for (final entry in towers.entries) {
      final button = await _buildTowerButton(entry.key, entry.value, index);
      add(button);
      index++;
    }
  }

  Future<ButtonComponent> _buildTowerButton(
    String label,
    BaseTower Function(Vector2) factory,
    int index,
  ) async {
    final buttonSize = Vector2(160, 50);
    final position = Vector2(10, 20 + index * 70);

    final defaultComponent = RectangleComponent(
      size: buttonSize,
      paint: flutter.Paint()..color = flutter.Colors.green[700]!,
    );

    final pressedComponent = RectangleComponent(
      size: buttonSize,
      paint: flutter.Paint()..color = flutter.Colors.green[900]!,
    );

    final text = TextComponent(
      text: label,
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

    final button = ButtonComponent(
      position: position,
      size: buttonSize,
      button: defaultComponent,
      buttonDown: pressedComponent,
      children: [text],
      onPressed: () => onTowerSelected(factory),
    );

    return button;
  }
}
