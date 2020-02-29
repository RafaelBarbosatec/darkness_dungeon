import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
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

  void moveCamera(double displacement, Directional directional);
}
