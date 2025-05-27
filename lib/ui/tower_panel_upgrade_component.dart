import 'package:flutter/material.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:microworld_td/game/player.dart';

class TowerPanelUpgradeComponent extends StatefulWidget 
{
  final GamePlay game;

  const TowerPanelUpgradeComponent({super.key, required this.game});

  @override
  State<TowerPanelUpgradeComponent> createState() => _TowerPanelUpgradeComponentState();
}

class _TowerPanelUpgradeComponentState extends State<TowerPanelUpgradeComponent> 
{
  late Player player;

  @override
  Widget build(BuildContext context) 
  {
    
    return Transform.translate
    (
        offset: const Offset(0, 750),
        child: Container
        (
        width: 1280,
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.brown[800],
          border: Border.all(color: Colors.brown.shade900, width: 4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section: Tower image + targeting buttons
            Column(
              children: [
                //Image.asset('assets/dart_monkey.png', width: 60, height: 60), // Replace with your tower image
                const SizedBox(height: 8),
                const Text("Dart Monkey", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Pop Count: 0"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 3,
                  children: [
                    targetButton("FIRST"),
                    targetButton("LAST"),
                    targetButton("CLOSE"),
                  //targetButton("STRONG"),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Middle section: Sell button
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () {},
                  child: const Text("SELL FOR \$172"),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Right section: Upgrade paths
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  upgradePath("Path 1", "XP TO UNLOCK"),
                  upgradePath("Path 2", "XP TO UNLOCK"),
                  upgradePath("Path 3", "XP TO UNLOCK"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget targetButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[600],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }

  Widget upgradePath(String pathLabel, String status) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 40,
          color: Colors.grey[700],
          child: Center(child: Text(status, textAlign: TextAlign.center)),
        ),
        const SizedBox(height: 4),
        Text(pathLabel),
      ],
    );
  }
}

