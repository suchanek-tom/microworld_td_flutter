import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/widgets.dart';
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
  Widget build(BuildContext context) 
  {
    return Transform.translate(
      offset: Offset(1280, 0), 
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
