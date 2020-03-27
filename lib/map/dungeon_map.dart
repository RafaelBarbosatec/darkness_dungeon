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
    List.generate(40, (y) {
      List.generate(70, (x) {
        ///SALÃO 1
        if (x == 3 && y >= 4 && y < 10) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 3 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 4 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 10 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 4 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 9 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 10 && x == 9) {
          tileList.add(Tile(
            'tile/wall_bottom_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 5 && y <= 9 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        /// CORREDOR 1

        if (y == 4 && x >= 10 && x <= 18) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 5 && x >= 9 && x <= 18) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 5 && y <= 12 && x == 19) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 9 && x >= 10 && x <= 14) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 9 && x == 15) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 10 && y <= 11 && x == 15) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 12 && x == 15) {
          tileList.add(Tile(
            'tile/wall_left_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 6 && y <= 8 && x >= 9 && x <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        if (y >= 9 && y <= 13 && x >= 16 && x <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        /// CORREDOR 2

        if (y == 12 && x >= 19 && x <= 35) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 13 && x >= 19 && x <= 35) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 13 && y <= 20 && x == 36) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 21 && x <= 35 && x >= 33) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 18 && y <= 20 && x == 32) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 17 && x == 32) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 17 && x <= 31 && x >= 9) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 17 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 12 && x <= 14 && x >= 6) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 13 && x <= 15 && x >= 6) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 13 && y <= 28 && x == 5) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 14 && y <= 16 && x >= 6 && x <= 35) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        if (y >= 17 && y <= 20 && x >= 33 && x <= 35) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        /// CORREDOR 3

        if (y == 18 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 18 && x >= 10 && x <= 25) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 19 && x >= 9 && x <= 25) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 19 && y <= 30 && x == 26) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 31 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 24 && y <= 30 && x == 22) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 23 && x >= 10 && x <= 21) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 23 && x == 22) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 23 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 17 && y <= 29 && x >= 6 && x <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        if (y >= 20 && y <= 22 && x >= 9 && x <= 25) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        if (y >= 23 && y <= 30 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }

        /// SALÃO 2

        if (y >= 24 && y <= 27 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 28 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 28 && x >= 10 && x <= 13) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 29 && x >= 9 && x <= 13) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 28 && x >= 4 && x <= 5) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }
        if (y == 29 && x >= 4 && x <= 5) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 29 && y <= 36 && x == 3) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y == 37 && x >= 4 && x <= 13) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 29 && y <= 36 && x == 14) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: true,
          ));
        }

        if (y >= 30 && y <= 36 && x >= 4 && x <= 13) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
          ));
        }
      });
    });

    return MapWorld(tileList);
  }

  static List<GameDecoration> decorations() {
    return [
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPosition: getRelativeTilePosition(6, 8),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(5, 4),
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
        initPosition: getRelativeTilePosition(6, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(7, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/bookshelf.png',
        initPosition: getRelativeTilePosition(10, 5),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(12, 5),
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
        initPosition: getRelativeTilePosition(13, 5),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPosition: getRelativeTilePosition(14, 5),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/bookshelf.png',
        initPosition: getRelativeTilePosition(17, 5),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(18, 7),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(12, 8),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(16, 12),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(20, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/prisoner.png',
        initPosition: getRelativeTilePosition(21, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(22, 13),
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
        initPosition: getRelativeTilePosition(24, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(26, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/prisoner.png',
        initPosition: getRelativeTilePosition(27, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(28, 13),
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
        initPosition: getRelativeTilePosition(30, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(32, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/prisoner.png',
        initPosition: getRelativeTilePosition(33, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(34, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(24, 16),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/barrel.png',
        initPosition: getRelativeTilePosition(35, 14),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(14, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(12, 13),
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
        initPosition: getRelativeTilePosition(13, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(9, 13),
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
        initPosition: getRelativeTilePosition(8, 13),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_green.png',
        initPosition: getRelativeTilePosition(7, 13),
        width: 32,
        height: 32,
      ),
    ];
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
