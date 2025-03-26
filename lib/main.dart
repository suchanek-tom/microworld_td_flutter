import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/microworld_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "tiny world TD",
      home: GameWidget(game: MicroworldGame()),
    );
  }
}
