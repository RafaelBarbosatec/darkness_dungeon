import 'dart:math';

import 'package:darkness_dungeon/core/map/tile.dart';
import 'package:flutter/material.dart';

class MyMaps {
  static List<List<Tile>> state1(Size size) {
    return List.generate(35, (indexRow) {
      return List.generate(70, (indexColumm) {
//        if (indexColumm == 2 && indexRow >= 5 && indexRow <= 10) {
//          return Tile('tile/wall_left.png', collision: true);
//        }
//        if (indexRow == 4 && indexColumm == 3) {
//          return Tile('tile/wall_left_and_bottom.png', collision: true);
//        }
//        if (indexRow == 5 && indexColumm == 3) {
//          return Tile('tile/wall.png', collision: true);
//        }
//        if (indexRow == 3 && indexColumm >= 4 && indexColumm <= 28) {
//          return Tile('tile/wall_bottom.png', collision: true);
//        }
//        if (indexRow == 4 && indexColumm >= 4 && indexColumm <= 28) {
//          if (indexColumm >= 15 && indexColumm < 28 && indexColumm % 4 == 0) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('',
//                    animation: FlameAnimation.Animation.sequenced(
//                        "itens/torch_spritesheet.png", 6,
//                        textureWidth: 16, textureHeight: 16)));
//          }
//
//          if (indexColumm % 3 == 0) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration(
//                  'itens/flag_red.png',
//                ));
//          }
//
//          if (indexColumm == 11) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/bookshelf.png'));
//          }
//
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        if (indexRow == 11 && indexColumm == 2) {
//          return Tile('tile/wall_bottom_left.png', collision: true);
//        }
//
//        if (indexRow == 11 && indexColumm >= 3 && indexColumm <= 19) {
//          return Tile('tile/wall_top.png', collision: true);
//        }
//
//        if (indexRow == 11 && indexColumm == 20) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow >= 4 && indexRow <= 20 && indexColumm == 29) {
//          return Tile('tile/wall_right.png', collision: true);
//        }
//
//        if (indexRow >= 12 && indexRow <= 23 && indexColumm == 20) {
//          return Tile('tile/wall_left.png', collision: true);
//        }
//
//        if (indexRow == 21 && indexColumm == 29) {
//          return Tile('tile/wall_right_and_bottom.png', collision: true);
//        }
//        if (indexRow == 22 && indexColumm == 29) {
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        if (indexRow == 22 && indexColumm == 30) {
//          return Tile('tile/wall_right_and_bottom.png', collision: true);
//        }
//        if (indexRow == 23 && indexColumm == 30) {
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        if (indexRow == 23 && indexColumm == 31) {
//          return Tile('tile/wall_right_and_bottom.png', collision: true);
//        }
//        if (indexRow == 24 && indexColumm == 31) {
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        if (indexRow == 23 && indexColumm >= 32 && indexColumm < 45) {
//          return Tile('tile/wall_bottom.png', collision: true);
//        }
//
//        if (indexRow == 24 && indexColumm >= 32 && indexColumm < 45) {
//          if (indexColumm % 2 == 0) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/flag_green.png'));
//          }
//
//          if (indexColumm == 35) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/prisoner.png'));
//          }
//
//          if (indexColumm == 37) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/prisoner.png'));
//          }
//
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        if (indexRow == 24 && indexColumm == 21) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 25 && indexColumm == 22) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 26 && indexColumm == 23) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 27 && indexColumm == 24) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 28 && indexColumm == 25) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 29 && indexColumm == 26) {
//          return Tile('tile/wall_turn_left_top.png', collision: true);
//        }
//
//        if (indexRow == 30 && indexColumm == 26) {
//          return Tile('tile/wall_bottom_left.png', collision: true);
//        }
//
//        if (indexRow == 30 && indexColumm >= 27 && indexColumm < 65) {
//          return Tile('tile/wall_top.png', collision: true);
//        }
//
//        if (indexRow == 30 && indexColumm == 65) {
//          return Tile('tile/wall_bottom_right.png', collision: true);
//        }
//
//        if (indexRow <= 29 && indexRow >= 10 && indexColumm == 65) {
//          return Tile('tile/wall_right.png', collision: true);
//        }
//
//        // Salão chefão
//
//        if (indexRow == 23 && indexColumm == 45) {
//          return Tile('tile/wall_left_and_top.png', collision: true);
//        }
//
//        if (indexRow == 22 && indexColumm == 46) {
//          return Tile('tile/wall_left_and_top.png', collision: true);
//        }
//
//        if (indexRow == 21 && indexColumm == 47) {
//          return Tile('tile/wall_left_and_top.png', collision: true);
//        }
//
//        if (indexRow <= 20 && indexRow >= 10 && indexColumm == 47) {
//          return Tile('tile/wall_left.png', collision: true);
//        }
//
//        if (indexRow == 9 && indexColumm == 47) {
//          return Tile('tile/wall_top_inner_left.png', collision: true);
//        }
//
//        if (indexRow == 9 && indexColumm == 65) {
//          return Tile('tile/wall_top_inner_right.png', collision: true);
//        }
//
//        if (indexRow == 9 && indexColumm >= 48 && indexColumm < 65) {
//          return Tile('tile/wall_bottom.png', collision: true);
//        }
//
//        if (indexRow == 10 && indexColumm >= 48 && indexColumm < 65) {
//          if (indexColumm == 56) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/flag_red.png'));
//          }
//
//          if (indexColumm == 52 ||
//              indexColumm == 54 ||
//              indexColumm == 58 ||
//              indexColumm == 60) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('itens/prisoner.png'));
//          }
//
//          if (indexColumm == 53 ||
//              indexColumm == 55 ||
//              indexColumm == 57 ||
//              indexColumm == 59) {
//            return Tile('tile/wall.png',
//                collision: true,
//                decoration: TileDecoration('',
//                    animation: FlameAnimation.Animation.sequenced(
//                        "itens/torch_spritesheet.png", 6,
//                        textureWidth: 16, textureHeight: 16)));
//          }
//
//          return Tile('tile/wall.png', collision: true);
//        }
//
//        //CHÃO
//
//        if (indexRow == 5 && indexColumm >= 4 && indexColumm <= 28) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow >= 6 &&
//            indexRow <= 10 &&
//            indexColumm >= 3 &&
//            indexColumm <= 28) {
//          if (indexRow == 7 && indexColumm == 25) {
//            //return Tile(randomFloor(), enemy: SmileEnemy());
//          }
//
//          if (indexRow == 8 && indexColumm == 18) {
//            //return Tile(randomFloor(), enemy: GoblinEnemy());
//          }
//
//          if (indexRow == 6 && (indexColumm == 27 || indexColumm == 26)) {
//            return Tile(randomFloor(),
//                collision: true,
//                decoration: TileDecoration('itens/barrel.png'));
//          }
//
//          if (indexRow == 10 && indexColumm >= 3 && indexColumm <= 5) {
//            return Tile(randomFloor(),
//                decoration: TileDecoration('itens/barrel.png'));
//          }
//
//          if (indexRow == 6 && indexColumm == 15) {
//            return Tile(randomFloor(),
//                collision: true, decoration: TileDecoration('itens/table.png'));
//          }
//
//          return Tile(randomFloor());
//        }
//
//        if (indexRow >= 11 &&
//            indexRow <= 22 &&
//            indexColumm >= 20 &&
//            indexColumm <= 28) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 23 && indexColumm >= 20 && indexColumm <= 29) {
//          if (indexColumm == 29 || indexColumm == 28) {
//            return Tile(randomFloor(),
//                collision: true,
//                decoration: TileDecoration('itens/barrel.png'));
//          }
//
//          if (indexColumm == 24) {
//            //return Tile(randomFloor(), enemy: GoblinEnemy());
//          }
//
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 24 && indexColumm >= 21 && indexColumm <= 30) {
//          return Tile(randomFloor());
//        }
//        if (indexRow == 25 && indexColumm >= 22 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//        if (indexRow == 26 && indexColumm >= 23 && indexColumm <= 65) {
//          if (indexColumm == 30) {
//            //return Tile(randomFloor(), enemy: SmileEnemy());
//          }
//
//          if (indexColumm == 54 || indexColumm == 58) {
//            return Tile(randomFloor(),
//                collision: true, decoration: TileDecoration('itens/table.png'));
//          }
//          return Tile(randomFloor());
//        }
//        if (indexRow == 27 && indexColumm >= 24 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//        if (indexRow == 28 && indexColumm >= 25 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 29 && indexColumm >= 26 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 24 && indexColumm >= 45 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 23 && indexColumm >= 46 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//
//        if (indexRow == 22 && indexColumm >= 47 && indexColumm <= 65) {
//          return Tile(randomFloor());
//        }
//
//        // CHEFÃO 13 56
//
//        if (indexRow >= 11 &&
//            indexRow <= 21 &&
//            indexColumm >= 48 &&
//            indexColumm < 65) {
//          if (indexRow == 13 && indexColumm == 56) {
//            //return Tile(randomFloor(), enemy: BossEnemy());
//          }
//
//          if (indexRow == 14 && indexColumm == 52) {
////            return Tile(
////              randomFloor(),
////              enemy: MiniBossEnemy(),
////            );
//          }
//
//          if (indexRow == 14 && indexColumm == 60) {
////            return Tile(
////              randomFloor(),
////              enemy: MiniBossEnemy(),
////            );
//          }
//
//          if (indexRow == 16 && indexColumm == 54) {
////            return Tile(
////              randomFloor(),
////              enemy: MiniBossEnemy(),
////            );
//          }
//
//          if (indexRow == 16 && indexColumm == 58) {
////            return Tile(
////              randomFloor(),
////              enemy: MiniBossEnemy(),
////            );
//          }
//
//          if (indexRow == 18 && indexColumm == 56) {
////            return Tile(
////              randomFloor(),
////              enemy: MiniBossEnemy(),
////            );
//          }
//
//          if (indexRow == 11 && indexColumm >= 48 && indexColumm < 65) {
//            return Tile('tile/floor_10.png');
//          }
//
//          if (indexRow == 12 && indexColumm >= 48 && indexColumm < 65) {
//            return Tile('tile/floor_6.png');
//          }
//
//          return Tile(randomFloor());
//        }

        if (indexRow > 5 && indexRow < 10) {
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
