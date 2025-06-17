

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:microworld_td/game/player.dart';

class TowerPanelComponent extends StatefulWidget {
  final GamePlay game;

  const TowerPanelComponent({super.key, required this.game});

  @override
  State<TowerPanelComponent> createState() => TowerPanelComponentState();
}

class TowerPanelComponentState extends State<TowerPanelComponent> {
  late Timer _timer;
  int coins = GameState.coins;
  int lives = GameState.lives;
  int wave = GameState.waveNumber;

  late Player player = Player();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (mounted) {
        setState(() {
          coins = GameState.coins;
          lives = GameState.lives;
          wave = GameState.waveNumber;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BaseTower> towerList = player.getTowers;

    return Transform.translate(
      offset: const Offset(765, 0),
      child: Container(
        width: 90,
        height: 385,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/UI/wood_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            
            const Text(
              'DIFFICULTY',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.health_and_safety, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text('$lives', style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 8),
                Icon(Icons.attach_money, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text('$coins', style: const TextStyle(color: Colors.white)),
              ],
            ),
            const Icon(Icons.arrow_drop_up, size: 48, color: Colors.red),
            Expanded(
              child: GridView.builder
              (
                padding: const EdgeInsets.all(6),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                (
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) 
                {
                  bool hasTower = index < towerList.length;
                  return ElevatedButton
                  (
                    style: ElevatedButton.styleFrom
                    (
                      backgroundColor: Colors.green.withOpacity(0.3),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder
                      (
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: hasTower ? Colors.green : Colors.brown[700],
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: hasTower
                          ? Image.asset("assets/${towerList[index].sprit_icon_path}"
                              , // Assicurati che ogni tower abbia un `spritePath`
                              fit: BoxFit.cover,
                            )
                          : const Icon
                          (
                          Icons.bug_report,
                          color: Colors.black,
                          ),
                      ),
                    onPressed: () 
                    { 
                      BaseTower tower = towerList.elementAt(index);
                      widget.game.placingTower(tower);
                      widget.game.add(tower);
                    },
                  );
                },
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 48, color: Colors.red),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown[900],
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'BATTLE: $wave',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'WAVES: 25',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              onPressed: () {
                //widget.game.startGame();
              },
              child: const Text('START', style: TextStyle(color: Colors.white)),
            ),
            IconButton(
              icon: const Icon(Icons.fast_forward, color: Colors.red, size: 24),
              onPressed: () {
                //widget.game.speedUpGame();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
