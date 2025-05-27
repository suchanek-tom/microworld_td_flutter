import 'package:flutter/material.dart';
import 'package:microworld_td/game/microworld_game.dart';

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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resumeGame();
              },
              child: const Text('Resume'),
            ),
          ],
        ),
      ),
    );
  }
}
