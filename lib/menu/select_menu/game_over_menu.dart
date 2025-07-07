import 'package:flutter/material.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/microworld_game.dart';
import 'package:microworld_td/menu/main_menu/home.dart'; 

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
            // --- Pulsante "Riprova" ---
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent), 
              onPressed: () {
                game.resetGame();
                // Rimuovi l'overlay del menu di Game Over
                game.overlays.remove('GameOverMenu');
              },
              child: const Text('Riprova', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 15), 

            // --- Pulsante "Quit to Menu" ---
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {    
                GameState.isGameOver = false;
                print(game.overlays.activeOverlays);
                game.overlays.remove('GameOverMenu');
                print(game.overlays.activeOverlays);
            
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomePage()), // O SelectLevelPage, a seconda di dove vuoi che torni
                  (route) => false,
                );
              },
              child: const Text('Esci al Menu', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}