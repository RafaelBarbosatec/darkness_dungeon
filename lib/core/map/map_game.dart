import 'tile.dart';

abstract class MapGame {
  double paddingLeft = 0;
  double paddingTop = 0;
  final List<List<Tile>> map;

  MapGame(this.map);

  void resetMap(List<List<Tile>> map);
}
