import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/widgets.dart';

class TowerPanelComponent extends StatelessWidget 
{
  const TowerPanelComponent({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return  Transform.translate(
      offset: Offset(750, 0), 
      child: Container(
        color: const Color.fromARGB(255, 209, 10, 10).withAlpha(100),
        width: 180,
        height: 600,
        ));        
  }
}


  /* @override
  Future<void> onLoad() async 
  {
    size = Vector2(180, 600); // Panel size
    position = Vector2(800 - 180, 0); // Right side positioning
    
    // Background panel
    add(
      RectangleComponent(
        size: size,
        paint: flutter.Paint()..color = flutter.Colors.black.withOpacity(0.5),
        priority: -1,
      ),
    );

    // Tower buttons
    const towerNames = ['black widow', 'bee', 'cricket','kite'];
    for (int i = 0; i < towerNames.length; i++) {
      add(_buildTowerButton(towerNames[i], i));
    }
  }

  PositionComponent _buildTowerButton(String label, int index) 
  {
    final position = Vector2(10, index * 60);
    final size = Vector2(50, 50);

    final background = RectangleComponent(
      size: size,
      
      paint: flutter.Paint()..color = flutter.Colors.green[700]!,
    );

    final text = TextComponent
    (
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
  } */
  

