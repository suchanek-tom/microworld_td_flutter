import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';
import 'package:microworld_td/game/components/towers/types/black_widow.dart';
import 'package:microworld_td/game/components/towers/types/stag_beeatle.dart';

class Player 
{
  late List<BaseTower> towerlist = [];
  Player()
  {
    towerlist.addAll([BeeTower(),BlackWidowTower(),StagBeeatleTower()]);
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