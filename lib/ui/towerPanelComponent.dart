import 'package:flame/components.dart';
import 'package:flutter/material.dart' as flutter;

class TowerPanelComponent extends PositionComponent {
  TowerPanelComponent();

  @override
  Future<void> onLoad() async {
    size = Vector2(120, 200); // Panel size
    position = Vector2(800 - 130, 100); // Right side positioning

    // Background panel
    add(
      RectangleComponent(
        size: size,
        paint: flutter.Paint()..color = flutter.Colors.black.withOpacity(0.5),
        priority: -1,
      ),
    );

    // Tower buttons
    const towerNames = ['Sniper', 'Sticky', 'Venom'];
    for (int i = 0; i < towerNames.length; i++) {
      add(_buildTowerButton(towerNames[i], i));
    }
  }

  PositionComponent _buildTowerButton(String label, int index) {
    final position = Vector2(10, index * 60 + 10);
    final size = Vector2(100, 50);

    final background = RectangleComponent(
      size: size,
      paint: flutter.Paint()..color = flutter.Colors.green[700]!,
    );

    final text = TextComponent(
      text: label,
      position: size / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const flutter.TextStyle(
          fontSize: 16,
          color: flutter.Colors.white,
          fontWeight: flutter.FontWeight.bold,
        ),
      ),
    );

    final button = PositionComponent(
      position: position,
      size: size,
    );

    button.add(background);
    button.add(text);

    return button;
  }
}
