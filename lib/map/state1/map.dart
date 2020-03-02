import 'dart:math';

import 'package:darkness_dungeon/core/map/tile.dart';

class State1Map {
  static List<List<Tile>> map() {
    return List.generate(35, (indexRow) {
      return List.generate(70, (indexColumm) {
        if (indexRow == 3) {
          return Tile('tile/wall_bottom.png', collision: true, size: 32);
        }
        if (indexRow == 4) {
          return Tile('tile/wall.png', collision: true, size: 32);
        }

        if (indexRow == 9) {
          return Tile('tile/wall_top.png', collision: true, size: 32);
        }

        if (indexRow > 4 && indexRow < 9) {
          return Tile(randomFloor(), size: 32);
        }

        return Tile('', size: 32);
      });
    });
  }

  static String randomFloor() {
    int p = Random().nextInt(6);
    String sprite = "";
    switch (p) {
      case 0:
        sprite = 'tile/floor_1.png';
        break;
      case 1:
        sprite = 'tile/floor_1.png';
        break;
      case 2:
        sprite = 'tile/floor_2.png';
        break;
      case 3:
        sprite = 'tile/floor_2.png';
        break;
      case 4:
        sprite = 'tile/floor_3.png';
        break;
      case 5:
        sprite = 'tile/floor_4.png';
        break;
    }
    return sprite;
  }
}
