import 'package:flutter/material.dart' as flutter;
import 'package:flutter/widgets.dart';

class TowerPanelComponent extends StatelessWidget 
{
  const TowerPanelComponent({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Transform.translate(
      offset: Offset(850, 60), 
      child: Container(
        width: 120,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/sprites/wood_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('DIFFICULTY', style: TextStyle(color: flutter.Colors.white, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(flutter.Icons.remove, color: flutter.Colors.white),
                SizedBox(width: 10),
                Icon(flutter.Icons.attach_money, color: flutter.Colors.white),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: flutter.Colors.green.withOpacity(0.3),
                  child: Center(child: Icon(flutter.Icons.bug_report, color: flutter.Colors.black)),
                );
              },
            ),
            const SizedBox(height: 10),
            const Text('BATTLE: 9\nWAVES: 25', textAlign: TextAlign.center, style: TextStyle(color: flutter.Colors.white)),
            const Spacer(),
            const Icon(flutter.Icons.fast_forward, color: flutter.Colors.red, size: 40),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
    /* 
    return  Transform.translate(
      offset: Offset(750, 165), 
      child: Container(
        color: const Color.fromARGB(255, 209, 10, 10).withAlpha(100),
        width: 180,
        height: 615,
      )); */       

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
  

