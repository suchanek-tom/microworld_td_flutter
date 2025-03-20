import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Enemy extends PositionComponent {
  final Vector2 targetPosition; 
  final double speed = 50;

  Enemy({required Vector2 position, required this.targetPosition}) {
    this.position = position;
    size = Vector2(30, 30);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF00008B),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    Vector2 direction = (targetPosition - position).normalized();

    position += direction * speed * dt;
  }
}
