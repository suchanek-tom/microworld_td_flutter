import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';

class PauseMenu extends StatelessWidget {
  final MicroworldGame game;

  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game is Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () {
                game.resumeGame();
              },
              child: const Text('Resume', style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () {
                game.pauseGame();

                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SelectLevelPage()),
                  (route) => false,
                );
              },
              child: const Text('Quit to Menu', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
