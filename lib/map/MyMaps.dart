
import 'dart:math';

import 'package:darkness_dungeon/core/Decoration.dart';
import 'package:darkness_dungeon/enemies/GoblinEnemy.dart';
import 'package:darkness_dungeon/enemies/SmileEnemy.dart';
import 'package:darkness_dungeon/core/map/TileMap.dart';
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
                collision: true,
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

        if(indexRow >=12 && indexRow <=23  && indexColumm ==20){
          return TileMap('tile/wall_left.png',collision: true);
        }

        if(indexRow == 21 && indexColumm == 29){
          return TileMap('tile/wall_right_and_bottom.png',collision: true);
        }
        if(indexRow == 22 && indexColumm == 29){
          return TileMap('tile/wall.png',collision: true);
        }

        if(indexRow == 22 && indexColumm == 30){
          return TileMap('tile/wall_right_and_bottom.png',collision: true);
        }
        if(indexRow == 23 && indexColumm == 30){
          return TileMap('tile/wall.png',collision: true);
        }

        if(indexRow == 23 && indexColumm == 31){
          return TileMap('tile/wall_right_and_bottom.png',collision: true);
        }
        if(indexRow == 24 && indexColumm == 31){
          return TileMap('tile/wall.png',collision: true);
        }

        if(indexRow == 23 && indexColumm >= 32 && indexColumm < 40){
          return TileMap('tile/wall_bottom.png',collision: true);
        }
        if(indexRow == 24 && indexColumm >= 32 && indexColumm < 40){

          if(indexColumm %2 == 0){
            return TileMap('tile/wall.png',collision: true,decoration: TileDecoration('itens/flag_green.png'));
          }

          if(indexColumm == 35){
            return TileMap('tile/wall.png',collision: true,decoration: TileDecoration('itens/prisoner.png'));
          }

          return TileMap('tile/wall.png',collision: true);
        }




        if(indexRow == 24 && indexColumm == 21){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 25 && indexColumm == 22){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 26 && indexColumm == 23){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 27 && indexColumm == 24){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 28 && indexColumm == 25){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 29 && indexColumm == 26){
          return TileMap('tile/wall_turn_left_top.png',collision: true);
        }

        if(indexRow == 30 && indexColumm == 26){
          return TileMap('tile/wall_bottom_left.png',collision: true);
        }
        if(indexRow == 30 && indexColumm >= 27 && indexColumm < 40){
          return TileMap('tile/wall_top.png',collision: true);
        }

        //CHÃO

        if(indexRow == 3 && indexColumm >= 4 && indexColumm <= 28){
          if(indexRow == 3 && indexColumm == 20) {
            return TileMap(randomFloor(),
                collision: true,
                decoration: TileDecoration('itens/barrel.png'));
          }

          return TileMap(randomFloor());
        }

        if(indexRow >= 4 && indexRow <= 10 && indexColumm >= 3 && indexColumm <= 28){

          if(indexRow == 5 && indexColumm == 23){
            return TileMap(randomFloor(),enemy: SmileEnemy());
          }

          if(indexRow == 10 && indexColumm == 23){
            return TileMap(randomFloor(),enemy: SmileEnemy());
          }

          if(indexRow == 10 && indexColumm >=3 && indexColumm <=5) {
            return TileMap(randomFloor(),
                decoration: TileDecoration('itens/barrel.png'));
          }

          if(indexRow == 5 && indexColumm == 15) {
            return TileMap(randomFloor(), collision: true,
                decoration: TileDecoration('itens/table.png'));
          }

          return TileMap(randomFloor());
        }

        if(indexRow >= 11 && indexRow <= 22 && indexColumm >= 20 && indexColumm <= 28){
          return TileMap(randomFloor());
        }

        if(indexRow == 23 && indexColumm >= 20 && indexColumm <= 29){
          if(indexColumm == 29 || indexColumm == 28){
            return TileMap(randomFloor(),
                collision: true,
                decoration: TileDecoration('itens/barrel.png'));
          }

          if(indexColumm == 24){
            return TileMap(randomFloor(),enemy: GoblinEnemy());
          }

          return TileMap(randomFloor());
        }

        if(indexRow == 24 && indexColumm >= 21 && indexColumm <= 30){
          return TileMap(randomFloor());
        }
        if(indexRow == 25 && indexColumm >= 22 && indexColumm <= 39){
          return TileMap(randomFloor());
        }
        if(indexRow == 26 && indexColumm >= 23 && indexColumm <= 39){
          return TileMap(randomFloor());
        }
        if(indexRow == 27 && indexColumm >= 24 && indexColumm <= 39){
          if(indexColumm == 30 || indexColumm == 35){
            return TileMap(randomFloor(),collision: true, decoration: TileDecoration('itens/table.png'));
          }
          return TileMap(randomFloor());
        }
        if(indexRow == 28 && indexColumm >= 25 && indexColumm <= 39){
          return TileMap(randomFloor());
        }

        if(indexRow == 29 && indexColumm >= 26 && indexColumm <= 39){
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