import 'dart:async';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/gameplay.dart';
import 'package:microworld_td/game/player.dart';

class TowerPanelComponent extends StatefulWidget {

  final GamePlay game;

  const TowerPanelComponent({super.key, required this.game});

  @override
  State<TowerPanelComponent> createState() => _TowerPanelComponentState();
}

class _TowerPanelComponentState extends State<TowerPanelComponent> {
  late Timer _timer;
  int coins = GameState.coins;
  int lives = GameState.lives;
  int wave = GameState.waveNumber;

  late Player player;
   
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
  Widget build(BuildContext context)
  {
    player = Player();
    List<BaseTower> towerList = player.getTowers;

    return Transform.translate(
      offset: const Offset(1280, 0),
      child: Container(
        width: 120,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sprites/wood_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'DIFFICULTY',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.health_and_safety, color: Colors.white),
                SizedBox(width: 10),
                Icon(Icons.attach_money, color: Colors.white),
              ],
            ),
            const SizedBox(height: 20),

            // GridView with ElevatedButtons
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
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.3),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () 
                  {
                    BaseTower tower = towerList.first;
                    tower.setPos = Vector2(100, 200);
                    widget.game.add(tower);
                    print('Torre #$index selezionata!');
                  },
                  child: const Icon(
                    Icons.bug_report,
                    color: Colors.black,
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
            Text(
              'WAVE: $wave\nLIVES: $lives\nCOINS: $coins',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.fast_forward, color: Colors.red, size: 40),
            const Icon(Icons.stop, color: Colors.red, size: 40),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
