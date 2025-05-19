import 'package:microworld_td/game/components/towers/baseTower.dart';
import 'package:microworld_td/game/components/towers/types/bee.dart';

class Player 
{

  late List<BaseTower> towerlist;
  Player()
  {
    towerlist.add(BeeTower());
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