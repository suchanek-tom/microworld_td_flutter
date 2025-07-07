import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';
import 'package:microworld_td/menu/select_menu/level_progress.dart';

class GameWinMenu extends StatelessWidget {
  final MicroworldGame game;
  final int currentLevel;

  const GameWinMenu({super.key, required this.game, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'YOU WIN!',
              style: TextStyle(color: Colors.greenAccent, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SelectLevelPage()),
                  (route) => false,
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
