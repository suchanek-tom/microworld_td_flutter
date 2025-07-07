import 'package:flutter/material.dart';
import 'package:microworld_td/menu/select_menu/select_levels_page.dart';
import 'package:microworld_td/game/microworld_game.dart';

class GameOverMenu extends StatelessWidget {
  final MicroworldGame game;

  const GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
           ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              game.resetGame(); 
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                '/levelpage',
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
