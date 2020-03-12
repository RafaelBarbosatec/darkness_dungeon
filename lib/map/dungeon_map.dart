import 'dart:math';

import 'package:darkness_dungeon/core/decoration/decoration.dart';
import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/map/map_world.dart';
import 'package:darkness_dungeon/core/map/tile.dart';
import 'package:darkness_dungeon/decoration/chest.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/enemies/goblin.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class DungeonMap {
  static const int tileSize = 32;

  static MapWorld map() {
    List<Tile> tileList = List();
    List.generate(35, (indexRow) {
      List.generate(70, (indexColumm) {
        if (indexRow == 3) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }
        if (indexRow == 4) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }

        if (indexRow == 9) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }

        if (indexRow > 4 && indexRow < 9) {
          tileList.add(Tile(
            randomFloor(),
            Position(indexColumm.toDouble(), indexRow.toDouble()),
          ));
          return;
        }
      });
    });

    return MapWorld(tileList);
  }

  static List<GameDecoration> decorations() {
    return [
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getWorldPosition(10, 5),
        width: 32,
        height: 32,
        collision: true,
      ),
      Chest(getWorldPosition(18, 7)),
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPosition: getWorldPosition(15, 7),
        width: 32,
        height: 32,
        collision: true,
      ),
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPosition: getWorldPosition(27, 6),
        width: 32,
        height: 32,
        collision: true,
      ),
      GameDecoration(
        animation: FlameAnimation.Animation.sequenced(
          "itens/torch_spritesheet.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        initPosition: getWorldPosition(4, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        animation: FlameAnimation.Animation.sequenced(
          "itens/torch_spritesheet.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        initPosition: getWorldPosition(8, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        animation: FlameAnimation.Animation.sequenced(
          "itens/torch_spritesheet.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        initPosition: getWorldPosition(12, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        animation: FlameAnimation.Animation.sequenced(
          "itens/torch_spritesheet.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        initPosition: getWorldPosition(16, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getWorldPosition(6, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getWorldPosition(10, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getWorldPosition(14, 4),
        width: 32,
        height: 32,
      )
    ];
  }

  static List<Enemy> enemies() {
    return [
      Goblin(initPosition: getWorldPosition(14, 6)),
      Imp(initPosition: getWorldPosition(10, 7)),
      Boss(initPosition: getWorldPosition(25, 6)),
    ];
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

  static Position getWorldPosition(int x, int y) {
    return Position(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
