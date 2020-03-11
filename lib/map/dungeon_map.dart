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
        initPositionRelativeTile: Position(10, 5),
        width: 32,
        height: 32,
        collision: true,
      ),
      Chest(Position(25, 6)),
      GameDecoration(
        spriteImg: 'itens/table.png',
        initPositionRelativeTile: Position(15, 7),
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
        initPositionRelativeTile: Position(4, 4),
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
        initPositionRelativeTile: Position(8, 4),
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
        initPositionRelativeTile: Position(12, 4),
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
        initPositionRelativeTile: Position(16, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPositionRelativeTile: Position(6, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPositionRelativeTile: Position(10, 4),
        width: 32,
        height: 32,
      ),
      GameDecoration(
        spriteImg: 'itens/flag_red.png',
        initPositionRelativeTile: Position(14, 4),
        width: 32,
        height: 32,
      )
    ];
  }

  static List<Enemy> enemies() {
    return [
      Goblin(initPositionRelativeTile: Position(14, 6)),
      Imp(initPositionRelativeTile: Position(10, 7)),
      Boss(initPositionRelativeTile: Position(20, 6)),
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
}
