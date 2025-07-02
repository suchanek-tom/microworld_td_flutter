import 'package:microworld_td/game/components/bullet/base_bullet.dart';

class WebBullet extends BaseBullet
{
  WebBullet({required super.tower, required super.target, required super.damage})
   : super(speed: 200);

  @override
  void hitTarget() {
    // TODO: implement hitTarget
  }
  
}