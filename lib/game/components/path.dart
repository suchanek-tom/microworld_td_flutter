import 'dart:ui';
import 'package:flame/components.dart';

class Path {
  List<Vector2> waypoints;

  Path({required this.waypoints});

  void drawPath(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF8B4513)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < waypoints.length - 1; i++) {
      canvas.drawLine(waypoints[i].toOffset(), waypoints[i + 1].toOffset(), paint);
    }
  }
}
