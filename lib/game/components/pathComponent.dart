import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class PathComponent extends PositionComponent {
  final List<Vector2> waypoints;
  
  PathComponent({required this.waypoints});

  @override
  void render(Canvas canvas)
  {
    super.render(canvas);

    final paint = Paint()
      ..color = const Color(0x00000000) 
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < waypoints.length - 1; i++) {
      canvas.drawLine(
        waypoints[i].toOffset(),
        waypoints[i + 1].toOffset(),
        paint,
      );
    }
  }
}
