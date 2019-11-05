
import 'dart:math';

import 'package:darkness_dungeon/decoration/Decoration.dart';
import 'package:darkness_dungeon/enemy/Enemy.dart';
import 'package:darkness_dungeon/enemy/GoblinEnemy.dart';
import 'package:darkness_dungeon/enemy/SmileEnemy.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/map/TileMap.dart';
import 'package:flutter/material.dart';

class MyMaps{
  static List<List<TileMap>> mainMap(Size size){
    return List.generate((size.height*2)~/16, (indexRow){
      return List.generate((size.width*2)~/16, (indexColumm){

        if(indexColumm == 2 && indexRow >= 3 && indexRow <= 10){
          return TileMap('tile/wall_left.png',collision: true);
        }
        if(indexRow == 2 && indexColumm == 3){
          return TileMap('tile/wall_left_and_bottom.png',collision: true);
        }
        if(indexRow == 3 && indexColumm == 3){
          return TileMap('tile/wall.png',collision: true);
        }
        if(indexRow == 1 && indexColumm >=4 && indexColumm <= 28){
          return TileMap('tile/wall_bottom.png',collision: true);
        }
        if(indexRow == 2 && indexColumm >=4 && indexColumm <= 28){

          if(indexColumm %2 == 0){
            return TileMap('tile/wall.png',
                decoration: TileDecoration('itens/flag_red.png'));
          }

          if(indexColumm == 11){
            return TileMap('tile/wall.png',
                decoration: TileDecoration('itens/bookshelf.png'));
          }

          return TileMap('tile/wall.png',collision: true);
        }

        if(indexRow == 11 && indexColumm == 2){
          return TileMap('tile/wall_bottom_left.png',collision: true);
        }

        if(indexRow == 11 && indexColumm >=3 && indexColumm <= 19){
          return TileMap('tile/wall_top.png',collision: true);

        }

        if(indexRow == 11 && indexColumm == 20){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow >=2 && indexRow <=20  && indexColumm ==29){
          return TileMap('tile/wall_right.png',collision: true);
        }

        if(indexRow >=12 && indexRow <=20  && indexColumm ==20){
          return TileMap('tile/wall_left.png',collision: true);
        }

        //CHÃO
        if(indexRow >= 4 && indexRow <= 10 && indexColumm >= 3 && indexColumm <= 28){

          if(indexRow == 5 && indexColumm == 26){
            return TileMap(randomFloor(),enemy: SmileEnemy());
          }

          if(indexRow == 5 && indexColumm == 20){
            return TileMap(randomFloor(),enemy: GoblinEnemy());
          }

          return TileMap(randomFloor());
        }

        if(indexRow == 3 && indexColumm >= 4 && indexColumm <= 28){
          if(indexRow == 3 && indexColumm == 20) {
            return TileMap(randomFloor(),
                decoration: TileDecoration('itens/barrel.png'));
          }
          return TileMap(randomFloor());
        }

        if(indexRow >= 11 && indexRow <= 20 && indexColumm >= 20 && indexColumm <= 28){
          return TileMap(randomFloor());
        }

        return TileMap('');
      });
    });
  }

  static String randomFloor(){
    int p = Random().nextInt(3);
    String sprite = "";
    switch(p){
      case 0: sprite = 'tile/floor_1.png'; break;
      case 1: sprite = 'tile/floor_2.png'; break;
      case 2: sprite = 'tile/floor_3.png'; break;
    }
    return sprite;
  }

}