
import 'dart:math';

import 'package:darkness_dungeon/Enemy.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/map/TileMap.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class MyMaps{
  static MapWord mainMap(Size size){
    return MapWord(
        List.generate((size.height*2)~/16, (indexColumm){
          return List.generate((size.width*2)~/16, (indexRow){

            if(indexColumm >= 5 && indexColumm<= 15 && indexRow ==20){
              return TileMap('tile/wall_left.png',collision: true);
            }

            if(indexColumm == 4 && indexRow ==20){
              return TileMap('tile/wall_top_inner_left.png',collision: true);
            }

            if(indexColumm == 4 && indexRow ==21){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==22){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==23){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==24){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==25){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==26){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==27){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==28){
              return TileMap('tile/wall_bottom.png',collision: true);
            }
            if(indexColumm == 4 && indexRow ==29){
              return TileMap('tile/wall_bottom.png',collision: true);
            }

            if(indexColumm == 5 && indexRow ==21){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==22){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==23){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==24){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==25){
              return TileMap('tile/wall.png',collision: true);
            }

            if(indexColumm == 8 && indexRow ==23){
              return TileMap('tile/floor_1.png',enemy: _createEnemy());
            }

            if(indexColumm == 8 && indexRow ==25){
              return TileMap('tile/floor_1.png',enemy: _createEnemy());
            }

            if(indexColumm == 10 && indexRow ==25){
              return TileMap('tile/floor_1.png',enemy: _createEnemy());
            }

            if(indexColumm == 8 && indexRow ==27){
              return TileMap('tile/floor_1.png',enemy: _createEnemy());
            }

            if(indexColumm == 5 && indexRow ==26){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==27){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==28){
              return TileMap('tile/wall.png',collision: true);
            }
            if(indexColumm == 5 && indexRow ==29){
              return TileMap('tile/wall.png',collision: true);
            }

            if(indexColumm == 4 && indexRow ==30){
              return TileMap('tile/wall_top_inner_right.png',collision: true);
            }

            if(indexColumm == 5 && indexRow ==30){
              return TileMap('tile/wall_right.png',collision: true);
            }

            if(indexColumm == 6 && indexRow ==30){
              return TileMap('tile/wall_right.png',collision: true);
            }
            if(indexColumm == 7 && indexRow ==30){
              return TileMap('tile/wall_right.png',collision: true);
            }
            if(indexColumm == 8 && indexRow ==30){
              return TileMap('tile/wall_right_and_bottom.png',collision: true);
            }

            if(indexColumm == 12 && indexRow == 30){
              return TileMap('tile/wall_left_and_top.png',collision: true);
            }

            if(indexColumm >= 13 && indexColumm <= 20 && indexRow ==30){
              return TileMap('tile/wall_right.png',collision: true);
            }

            if(indexColumm == 21 && indexRow == 30){
              return TileMap('tile/wall_bottom_right.png',collision: true);
            }

            if(indexColumm == 21 && indexRow <=29 && indexRow >=20){
              return TileMap('tile/wall_top.png',collision: true);
            }


            int p = Random().nextInt(3);
            String sprite = "";
            switch(p){
              case 0: sprite = 'tile/floor_1.png'; break;
              case 1: sprite = 'tile/floor_2.png'; break;
              case 2: sprite = 'tile/floor_3.png'; break;
            }
            return TileMap(sprite);
          });
        }),
        size
    );
  }

  static Enemy _createEnemy() {
    return Enemy()
      ..position = Rect.fromLTWH(0, 0, Enemy.size, Enemy.size)
      ..animation = FlameAnimation.Animation.sequenced("slime_idle.png", 6, textureWidth: 16, textureHeight: 16);
  }
}