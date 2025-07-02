import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/components/towers/types/black_widow.dart';
import 'package:microworld_td/game/components/towers/types/cricket.dart';
import 'package:microworld_td/game/components/towers/types/stag_beetle.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';

class Player 
{
  late List<BaseTower> towerlist = [];
  Player()
  {
    towerlist.addAll([BeeTower(),BlackWidowTower(),StagBeetleTower(),CricketTower()]);
  }
  
  List<BaseTower> get getTowers
  {
    return towerlist;
  }

  void addTowers(BaseTower newtower)
  {
    towerlist.add(newtower);
  }
  
}