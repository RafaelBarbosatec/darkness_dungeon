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
}

abstract class JoystickController extends Component {
  Function(Directional) changeDirectional;
  Function(String) action;
}
