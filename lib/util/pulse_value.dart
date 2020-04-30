import 'package:flutter/widgets.dart';

class PulseValue {
  final double speed;
  final Curve curve;
  double value;
  bool _animIsReverse = false;
  double _controllAnim = 0;
  PulseValue({this.speed = 1, this.curve = Curves.decelerate});

  void update(double dt) {
    if (_animIsReverse) {
      _controllAnim -= dt * speed;
    } else {
      _controllAnim += dt * speed;
    }

    if (_controllAnim >= 1) {
      _controllAnim = 1;
      _animIsReverse = true;
    }
    if (_controllAnim <= 0) {
      _controllAnim = 0;
      _animIsReverse = false;
    }
    value = Curves.decelerate.transform(_controllAnim);
  }
}
