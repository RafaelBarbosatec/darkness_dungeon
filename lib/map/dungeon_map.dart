import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/decoration/barrel.dart';
import 'package:darkness_dungeon/decoration/door.dart';
import 'package:darkness_dungeon/decoration/key.dart';
import 'package:darkness_dungeon/decoration/potion_life.dart';
import 'package:darkness_dungeon/decoration/spikes.dart';
import 'package:darkness_dungeon/decoration/torch.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/enemies/goblin.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:darkness_dungeon/enemies/mini_boss.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/npc/kid.dart';
import 'package:darkness_dungeon/npc/wizard_npc.dart';
import 'package:flame/position.dart';

class DungeonMap {
  static MapWorld map() {
    List<Tile> tileList = List();
    List.generate(40, (y) {
      List.generate(70, (x) {
        ///SALÃO 1
        if (x == 3 && y >= 4 && y < 10) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 3 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 4 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 10 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 4 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 9 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 10 && x == 9) {
          tileList.add(Tile(
            'tile/wall_bottom_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 5 && y <= 9 && x >= 4 && x <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        /// CORREDOR 1

        if (y == 4 && x >= 10 && x <= 18) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 5 && x >= 9 && x <= 18) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 5 && y <= 12 && x == 19) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 9 && x >= 10 && x <= 14) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 9 && x == 15) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 10 && y <= 11 && x == 15) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 12 && x == 15) {
          tileList.add(Tile(
            'tile/wall_left_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 6 && y <= 8 && x >= 9 && x <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 9 && y <= 13 && x >= 16 && x <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        /// CORREDOR 2

        if (y == 12 && x >= 19 && x <= 35) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 13 && x >= 19 && x <= 35) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 13 && y <= 20 && x == 36) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 21 && x <= 35 && x >= 33) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 18 && y <= 20 && x == 32) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 17 && x == 32) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 17 && x <= 31 && x >= 9) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 17 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 12 && x <= 14 && x >= 6) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 13 && x <= 15 && x >= 6) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 13 && y <= 16 && x == 5) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 20 && y <= 28 && x == 5) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 14 && y <= 16 && x >= 6 && x <= 35) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (x >= 33 && x <= 35 && y == 17) {
          tileList.add(Tile(
            'tile/floor_9.png',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }
        if (x >= 33 && x <= 35 && y >= 19 && y <= 20) {
          tileList.add(Tile(
            'tile/floor_10.png',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }
//        if (y >= 17 && y <= 20 && x >= 33 && x <= 35) {
//          tileList.add(Tile(
//            randomFloor(),
//            Position(x.toDouble(), y.toDouble()),
//          ));
//        }

        /// CORREDOR 3

        if (y == 18 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 18 && x >= 10 && x <= 25) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 19 && x >= 9 && x <= 25) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 19 && y <= 30 && x == 26) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 31 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 24 && y <= 30 && x == 22) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 23 && x >= 10 && x <= 21) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 23 && x == 22) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 23 && x == 9) {
          tileList.add(Tile(
            'tile/wall_left_and_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 17 && y <= 19 && x >= 7 && x <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 20 && y <= 29 && x >= 6 && x <= 8) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 20 && y <= 22 && x >= 9 && x <= 25) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 23 && y <= 24 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 25 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            'tile/floor_9.png',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 27 && y <= 30 && x >= 23 && x <= 25) {
          tileList.add(Tile(
            'tile/floor_10.png',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (x == 6 && y == 17) {
          tileList.add(Tile(
            'tile/wall_turn_left_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }
        if (x == 6 && y == 18) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }
        if (x == 6 && y == 19) {
          tileList.add(Tile(
            'tile/wall_left_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        /// SALÃO 2

        if (y >= 24 && y <= 27 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 28 && x == 9) {
          tileList.add(Tile(
            'tile/wall_right_and_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 28 && x >= 10 && x <= 18) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 29 && x >= 9 && x <= 18) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 28 && x >= 4 && x <= 5) {
          tileList.add(Tile(
            'tile/wall_top.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }
        if (y == 29 && x >= 4 && x <= 5) {
          tileList.add(Tile(
            'tile/wall.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 29 && y <= 36 && x == 3) {
          tileList.add(Tile(
            'tile/wall_left.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 37 && x >= 4 && x <= 18) {
          tileList.add(Tile(
            'tile/wall_bottom.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 29 && y <= 36 && x == 19) {
          tileList.add(Tile(
            'tile/wall_right.png',
            Position(x.toDouble(), y.toDouble()),
            collision: Collision(width: tileSize, height: tileSize),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y >= 30 && y <= 36 && x >= 4 && x <= 18) {
          tileList.add(Tile(
            randomFloor(),
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 20 && x == 38) {
          tileList.add(Tile(
            '',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }

        if (y == 39 && x == 3) {
          tileList.add(Tile(
            '',
            Position(x.toDouble(), y.toDouble()),
            width: tileSize,
            height: tileSize,
          ));
        }
      });
    });

    return MapWorld(tileList);
  }

  static GameDecoration table(int x, int y) => GameDecoration.sprite(
        Sprite('itens/table.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
        collision: Collision(
          width: tileSize,
          height: tileSize,
        ),
      );
  static GameDecoration table2(int x, int y) => GameDecoration.sprite(
        Sprite('itens/table_2.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize * 2,
        height: tileSize,
        collision: Collision(
          width: tileSize * 2,
          height: tileSize,
        ),
      );

  static GameDecoration flagRed(int x, int y) => GameDecoration.sprite(
        Sprite('itens/flag_red.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
      );
  static GameDecoration flagGreen(int x, int y) => GameDecoration.sprite(
        Sprite('itens/flag_green.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
      );

  static GameDecoration bookshelf(int x, int y) => GameDecoration.sprite(
        Sprite('itens/bookshelf.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
      );

  static GameDecoration prisoner(int x, int y) => GameDecoration.sprite(
        Sprite('itens/prisoner.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
      );

  static GameDecoration wallGrid(int x, int y) => GameDecoration.sprite(
        Sprite('tile/wall_grid.png'),
        initPosition: getRelativeTilePosition(x, y),
        width: tileSize,
        height: tileSize,
      );

  static GameDecoration torch(int x, int y, {bool empty = false}) =>
      Torch(getRelativeTilePosition(x, y), empty: empty);

  static List<GameDecoration> decorations() {
    return [
      table(6, 8),
      flagRed(5, 4),
      torch(6, 4),
      flagRed(7, 4),
      bookshelf(10, 5),
      flagRed(12, 5),
      torch(13, 5),
      flagRed(14, 5),
      bookshelf(17, 5),
      Barrel(getRelativeTilePosition(18, 7)),
      Barrel(getRelativeTilePosition(12, 8)),
      Barrel(getRelativeTilePosition(16, 12)),
      flagGreen(20, 13),
      prisoner(21, 13),
      flagGreen(22, 13),
      wallGrid(23, 13),
      torch(25, 13),
      prisoner(27, 13),
      torch(19, 13),
      torch(30, 13),
      torch(25, 19),
      wallGrid(31, 13),
      flagGreen(32, 13),
      prisoner(33, 13),
      flagGreen(34, 13),
      Barrel(getRelativeTilePosition(24, 16)),
      Barrel(getRelativeTilePosition(35, 14)),
      flagGreen(14, 13),
      torch(13, 13),
      prisoner(10, 13),
      wallGrid(11, 13),
      torch(8, 13),
      flagGreen(7, 13),
      table2(16, 15),
      Barrel(getRelativeTilePosition(6, 14)),
      wallGrid(10, 19),
      wallGrid(14, 19),
      wallGrid(18, 19),
      wallGrid(22, 19),
      torch(9, 19),
      torch(15, 19),
      torch(20, 19),
      torch(5, 29),
      torch(10, 29),
      torch(15, 29),
      torch(15, 37, empty: true),
      torch(7, 37, empty: true),
      torch(24, 31, empty: true),
      torch(34, 21, empty: true),
      wallGrid(13, 29),
      prisoner(11, 29),
      table(12, 21),
      table(19, 21),
      Barrel(getRelativeTilePosition(25, 20)),
      Barrel(getRelativeTilePosition(6, 26)),
      table2(10, 31),
      table2(10, 35),
      prisoner(16, 29),
      WizardNPC(getRelativeTilePosition(10, 6)),
      Spikes(getRelativeTilePosition(33, 18), damage: 80),
      Spikes(getRelativeTilePosition(34, 18), damage: 80),
      Spikes(getRelativeTilePosition(35, 18), damage: 80),
      Door(getRelativeTilePosition(7, 17)),
      DoorKey(getRelativeTilePosition(34, 20)),
      PotionLife(getRelativeTilePosition(23, 28), 50),
      PotionLife(getRelativeTilePosition(24, 29), 50),
      PotionLife(getRelativeTilePosition(35, 20), 50),
      Spikes(getRelativeTilePosition(23, 26), damage: 80),
      Spikes(getRelativeTilePosition(24, 26), damage: 80),
      Spikes(getRelativeTilePosition(25, 26), damage: 80),
      Kid(getRelativeTilePosition(18, 34)),
    ];
  }

  static List<Enemy> enemies() {
    return [
      Goblin(initPosition: getRelativeTilePosition(18, 8)),
      Goblin(initPosition: getRelativeTilePosition(16, 11)),
      Goblin(initPosition: getRelativeTilePosition(13, 16)),
      Goblin(initPosition: getRelativeTilePosition(8, 15)),
      Imp(initPosition: getRelativeTilePosition(21, 15)),
      Imp(initPosition: getRelativeTilePosition(28, 16)),
      Imp(initPosition: getRelativeTilePosition(35, 17)),
      Imp(initPosition: getRelativeTilePosition(32, 15)),
      MiniBoss(initPosition: getRelativeTilePosition(7, 26)),
      MiniBoss(initPosition: getRelativeTilePosition(25, 24)),
      Imp(initPosition: getRelativeTilePosition(18, 22)),
      Imp(initPosition: getRelativeTilePosition(6, 20)),
      Imp(initPosition: getRelativeTilePosition(11, 21)),
      Boss(initPosition: getRelativeTilePosition(16, 33)),
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
