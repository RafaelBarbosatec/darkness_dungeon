import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/new_tile.dart';
import 'package:flame/components/component.dart';

import 'tile.dart';

abstract class MapGame extends Component {
  final List<List<Tile>> map;

  MapGame(this.map);

  void resetMap(List<List<Tile>> map);

  bool isMaxTop();

  bool isMaxLeft();

  bool isMaxRight();

  bool isMaxBottom();

  List<Tile> getRendered();

  void moveCamera(double displacement, JoystickMoveDirectional directional);
}

abstract class NewMapGame extends Component {
  final Iterable<NewTile> map;

  NewMapGame(this.map);

//  void resetMap(List<List<Tile>> map);

  bool isMaxTop();

  bool isMaxLeft();

  bool isMaxRight();

  bool isMaxBottom();

  List<NewTile> getRendered();

  List<NewTile> getCollisionsRendered();

  void moveCamera(double displacement, JoystickMoveDirectional directional);
}
