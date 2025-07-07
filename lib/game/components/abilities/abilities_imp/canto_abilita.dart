import 'dart:async';
import 'dart:ui';
import 'package:microworld_td/game/components/abilities/abilities_action_service.dart';
import 'package:flame/components.dart';
import 'package:microworld_td/game/components/towers/baseTower.dart';

class CantoAbilita extends PositionComponent implements AbilitiesActionService 
{
  int damage_buff = 20; //15%
  double firerate_buff = 0.20;
  late CircleComponent rangeCircleBuff;

  @override
  String ability_name;

  final BaseTower tower;
  int _previousTowersInRangeCount = 0;
  int currentCount = 0;

  List<BaseTower> buffedTowers = [];

  CantoAbilita({required this.tower , required this.ability_name})
  {
    position = tower.position;
  }

  @override
  FutureOr<void> onLoad() {
  rangeCircleBuff = CircleComponent(
    radius: tower.range,
    paint: Paint()
      ..color = const Color.fromARGB(50, 174, 255, 0) 
      ..style = PaintingStyle.fill
      ..strokeWidth = 2,
    anchor: Anchor.center,
  );

  // 👇 Lascia il cerchio al centro di CantoAbilita
  rangeCircleBuff.position = Vector2.zero(); 
      add(rangeCircleBuff);
  }
  @override
  void update(double dt) 
  {
    buffedTowers = tower.parent!.children
      .whereType<BaseTower>()
      .where((towerB) => !towerB.isRemoved)
      .where((enemy) => position.distanceTo(enemy.position) < tower.range)
      .toList();

    currentCount = buffedTowers.length;

    if (currentCount != _previousTowersInRangeCount) {
      ability();
    }
    _previousTowersInRangeCount = currentCount;
  }

  @override 
  void ability() 
  {
    for (var element in buffedTowers) {
      if(element.canto_buffed == false)
      {
        element.canto_buffed = true;
        element.damage += damage_buff;
        element.canSeeCamo = true;
        element.fireRate *= (1 - firerate_buff);
      }
    }
  }  
}



