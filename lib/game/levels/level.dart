import 'package:flame/components.dart';

abstract class Level 
{
  late final List<Vector2> path;
  late final String level_tile_name;
  late final Map<int, List<Map<String, dynamic>>> waveConfiglevel;
  
  Level({required this.path, required this.level_tile_name,required this.waveConfiglevel});
}