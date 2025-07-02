import 'package:microworld_td/game/levels/first_level.dart';
import 'package:microworld_td/game/levels/level.dart';
import 'package:microworld_td/game/levels/second_level.dart';
import 'package:microworld_td/game/levels/third_level.dart';

class LevelManager 
{
  static int current_level = 0;

  static Level getLevel(int level)
  {
    switch(level)
    {
      case 1:
        return FirstLevel();

      case 2:
        return SecondLevel();

      case 3:
        return ThirdLevel();

      default:
        throw Exception("No level found with id: $level");
    }
  }
}