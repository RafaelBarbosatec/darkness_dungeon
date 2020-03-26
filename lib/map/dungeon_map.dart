import 'dart:math';

import 'package:bonfire/bonfire.dart';
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
        ///SALÃO 1
        if (indexColumm == 3 && indexRow >= 4 && indexRow < 10) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 3 && indexColumm >= 4 && indexColumm <= 8) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 4 && indexColumm >= 4 && indexColumm <= 8) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 10 && indexColumm >= 4 && indexColumm <= 8) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 4 && indexColumm == 9) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 3 && indexColumm == 9) {
          tileList.add(Tile(
            'tile/wall_top_inner_right.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 9 && indexColumm == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 10 && indexColumm == 9) {
          tileList.add(Tile(
            'tile/wall_bottom_right.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 5 &&
            indexRow <= 9 &&
            indexColumm >= 4 &&
            indexColumm <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(indexColumm.toDouble(), indexRow.toDouble()),
          ));
        }

        /// CORREDOR 1

        if (indexRow == 4 && indexColumm >= 9 && indexColumm <= 18) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 5 && indexColumm >= 9 && indexColumm <= 18) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 5 && indexRow <= 12 && indexColumm == 19) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 9 && indexColumm >= 10 && indexColumm <= 14) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 9 && indexColumm == 15) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 10 && indexRow <= 11 && indexColumm == 15) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 12 && indexColumm == 15) {
          tileList.add(Tile(
            'tile/wall_left_and_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 6 &&
            indexRow <= 8 &&
            indexColumm >= 9 &&
            indexColumm <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(indexColumm.toDouble(), indexRow.toDouble()),
          ));
        }

        if (indexRow >= 9 &&
            indexRow <= 12 &&
            indexColumm >= 16 &&
            indexColumm <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(indexColumm.toDouble(), indexRow.toDouble()),
          ));
        }

        /// CORREDOR 2

        if (indexRow == 12 && indexColumm >= 19 && indexColumm <= 35) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 13 && indexColumm >= 19 && indexColumm <= 35) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 13 && indexRow <= 20 && indexColumm == 36) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 21 && indexColumm <= 35 && indexColumm >= 33) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 18 && indexRow <= 20 && indexColumm == 32) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 17 && indexColumm == 32) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 17 && indexColumm <= 31 && indexColumm >= 9) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 12 && indexColumm <= 14 && indexColumm >= 6) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow == 13 && indexColumm <= 15 && indexColumm >= 6) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }

        if (indexRow >= 13 && indexRow <= 25 && indexColumm == 5) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
        }
      });
    });

    return MapWorld(tileList);
  }

  static List<GameDecoration> decorations() {
    return [];
    return [
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(10, 5),
        width: 32,
        height: 32,
        collision: true,
      ),
      Chest(getRelativeTilePosition(18, 7)),
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPosition: getRelativeTilePosition(15, 7),
        width: 32,
        height: 32,
        collision: true,
      ),
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPosition: getRelativeTilePosition(27, 6),
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
        initPosition: getRelativeTilePosition(4, 4),
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
        initPosition: getRelativeTilePosition(8, 4),
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
        initPosition: getRelativeTilePosition(12, 4),
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
        initPosition: getRelativeTilePosition(16, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(6, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(10, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(14, 4),
        width: 32,
        height: 32,
      )
    ];
  }

  static List<Enemy> enemies() {
    return [];
    return [
      Goblin(initPosition: getRelativeTilePosition(14, 6)),
      Imp(initPosition: getRelativeTilePosition(10, 7)),
      Boss(initPosition: getRelativeTilePosition(25, 6)),
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

  static Position getRelativeTilePosition(int x, int y) {
    return Position(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
