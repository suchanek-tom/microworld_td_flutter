import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microworld_td/game/components/game_state.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/ui/tower_panel_component.dart';
import 'package:mocktail/mocktail.dart';
import '../game/components/enemy/enemy_spawner_test.dart';

class TestTower extends Mock implements BaseTower{} 

 
  
void main() {
 testWidgets('Press tower button calls placingTower and reduces coins', (tester) async {
  GameState.coins = 1000; // Abbastanza soldi

  final mockGamePlay = MockGamePlay();
   
  final towerPanel = TowerPanelComponent(gamePlay: mockGamePlay);
  towerPanel.createState() as TowerPanelComponentState;

  await tester.pumpWidget(
  MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: Size(600, 400)), // simula schermo grande
      child: towerPanel,
    ),
  ),
);

  // Premi il primo bottone
  await tester.tap(find.byType(ElevatedButton).first);
  //mockGamePlay.placingTower(TestTower());
  await tester.pump();

  expect(mockGamePlay.isPlacingTower, isTrue);
  expect(GameState.coins, lessThan(1000)); // Soldi ridotti
});
}