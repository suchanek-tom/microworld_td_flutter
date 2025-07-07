import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';

class GameWinMenu extends StatelessWidget {
  final MicroworldGame game;

  const GameWinMenu({super.key, required this.game});

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
                game.overlays.remove("GameWinMenu");
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
