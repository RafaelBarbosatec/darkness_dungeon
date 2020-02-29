import 'dart:ui';

import 'package:flame/components/component.dart';

enum Directional {
  MOVE_TOP,
  MOVE_TOP_LEFT,
  MOVE_TOP_RIGHT,
  MOVE_RIGHT,
  MOVE_BOTTOM,
  MOVE_BOTTOM_RIGHT,
  MOVE_BOTTOM_LEFT,
  MOVE_LEFT,
  IDLE
}

abstract class JoystickListener {
  void joystickChangeDirectional(Directional directional);
  void joystickAction(int action);
}

abstract class JoystickController extends Component {
  JoystickListener joystickListener;
  @override
  void render(Canvas c) {}

  @override
  void update(double t) {}
}
