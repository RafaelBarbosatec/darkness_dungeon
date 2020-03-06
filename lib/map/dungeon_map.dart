import 'dart:math';

import 'package:darkness_dungeon/core/newCore/enemy/new_enemy.dart';
import 'package:darkness_dungeon/core/newCore/new_decoration.dart';
import 'package:darkness_dungeon/core/newCore/new_map_world.dart';
import 'package:darkness_dungeon/core/newCore/new_tile.dart';
import 'package:darkness_dungeon/enemies/Goblin2.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class DungeonMap {
  static NewMapWorld map() {
    List<NewTile> tileList = List();
    List.generate(35, (indexRow) {
      List.generate(70, (indexColumm) {
        if (indexRow == 3) {
          tileList.add(NewTile(
            'tile/wall_bottom.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }
        if (indexRow == 4) {
          tileList.add(NewTile(
            'tile/wall.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }

        if (indexRow == 9) {
          tileList.add(NewTile(
            'tile/wall_top.png',
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            collision: true,
          ));
          return;
        }

        if (indexRow > 4 && indexRow < 9) {
          tileList.add(NewTile(
            randomFloor(),
            Position(indexColumm.toDouble(), indexRow.toDouble()),
          ));
          return;
        }
      });
    });

    return NewMapWorld(tileList);
  }

  static List<NewDecoration> decorations = [
    NewDecoration(
      'itens/barrel.png',
      initPosition: Position(10, 5),
      width: 32,
      height: 32,
      collision: true,
    ),
    NewDecoration(
      'itens/table.png',
      initPosition: Position(15, 7),
      width: 32,
      height: 32,
      collision: true,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(4, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(8, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(12, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(16, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(6, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(10, 4),
      width: 32,
      height: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(14, 4),
      width: 32,
      height: 32,
    )
  ];

  static List<NewEnemy> enemies = [
    Goblin2(initPosition: Position(10, 7)),
  ];

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
