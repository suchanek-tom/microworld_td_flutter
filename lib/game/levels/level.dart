import 'package:flame/components.dart';

abstract class Level 
{
  late final List<Vector2> path;
  late final String level_tile_name;
  
  Level({required this.path, required this.level_tile_name});
}