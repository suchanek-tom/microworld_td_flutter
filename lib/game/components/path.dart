import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Path extends Component {
  List<Vector2> waypoints = [
    Vector2(50, 550), 
    Vector2(50, 400),
    Vector2(200, 400),
    Vector2(200, 250),
    Vector2(400, 250),
    Vector2(400, 450),
    Vector2(600, 450),
    Vector2(600, 300),
    Vector2(750, 300) 
  ];

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF8B4513)  
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < waypoints.length - 1; i++) {
      canvas.drawLine(waypoints[i].toOffset(), waypoints[i + 1].toOffset(), paint);
    }
  }
}
