import 'dart:ui';
import 'package:flame/components.dart';

class RangeCircleComponent extends PositionComponent {
  double radius;
  final Paint paintStyle;

  /// Custom visibility flag
  bool visible = false;

  RangeCircleComponent({
    required this.radius,
    required this.paintStyle,
  }) : super(
          size: Vector2.all(radius * 2),
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (!visible) return; // custom visibility check

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paintStyle,
    );
  }

  void updateRadius(double newRadius) {
    radius = newRadius;
    size = Vector2.all(newRadius * 2);
  }
}
