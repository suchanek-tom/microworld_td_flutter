import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Tower extends PositionComponent {
  Tower({required Vector2 position}) {
    this.position = position;
    size = Vector2(40, 40);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF8B0000),
    ));
  }
}
