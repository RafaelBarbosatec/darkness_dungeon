import 'package:darkness_dungeon/core/Decoration.dart';
import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/map/TileMap.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:flutter/material.dart';

abstract class MapControll{
  void moveRight(double displacement);

  void moveBottom(double displacement);

  void moveLeft(double displacement);

  void moveTop(double displacement);

  bool isMaxTop();

  bool isMaxLeft();

  bool isMaxRight();

  bool isMaxBottom();

}
abstract class MapGame {

  double paddingLeft = 0;
  double paddingTop = 0;

  void resetMap(List<List<TileMap>> map);
}

class MapWord implements MapGame,MapControll {

  List<List<TileMap>> map;
  final Size screenSize;
  final Player player;

  double paddingLeft = 0;
  double paddingTop = 0;
  double _lastPaddingLeft = -1;
  double _lastPaddingTop = -1;
  double maxTop = 0;
  double maxLeft = 0;
  bool maxRight = false;
  bool maxBottom = false;
  List<Rect> collisionsRect = List();
  List<TileMap> tilesMap = List();
  List<Enemy> enemies = List();
  List<TileDecoration> decorations = List();

  MapWord(this.map,this.player, this.screenSize) {
    player.setMapControll(this);
    inicializeMap();
  }

  void inicializeMap() {

    _confInitialCamera();

    if(map.isNotEmpty && map[0].isNotEmpty) {
      maxTop = (map.length * map[0][0].size) - screenSize.height;
      map.forEach((list) {
        if (list.length > maxLeft) {
          maxLeft = list.length.toDouble();
        }
      });

      maxLeft = maxLeft * map[0][0].size - screenSize.width;
    }
  }

  void render(Canvas canvas) {

    var decorationFront = List<TileDecoration>();

    tilesMap.forEach((tile) => tile.render(canvas));

    decorations.forEach((decoration){
      if(decoration.frontFromPlayer){
        decorationFront.add(decoration);
      }else {
        decoration.render(canvas);
      }
    });

    enemies.forEach((enemy) => _renderEnemy(enemy,canvas));

    player.render(canvas);

    decorationFront.forEach((d) => d.render(canvas));

  }

  void _renderEnemy(Enemy enemy,Canvas canvas) {

    if(enemy.isDieAndFinishAnimation()){
      return;
    }

    Rect positionFromMap = enemy.getCurrentPosition();

    if ((positionFromMap.left < screenSize.width + positionFromMap.width *2  &&
        positionFromMap.left > (positionFromMap.width * -2)) &&
        (positionFromMap.top < screenSize.height + positionFromMap.height *2 &&
            positionFromMap.top > (positionFromMap.height * -2))) {
      enemy.render(canvas);
    }
  }

  void update(double t) {

    if(_lastPaddingLeft !=  paddingLeft || _lastPaddingTop != paddingTop) {

      _lastPaddingLeft = paddingLeft;
      _lastPaddingTop = paddingTop;

      int countY = 0;
      collisionsRect.clear();
      tilesMap.clear();
      decorations.clear();
      map.forEach((tiles) {

        TileMap lastTile;

        tiles[0].position = Rect.fromLTWH(
            paddingLeft, (countY * tiles[0].size).toDouble() + paddingTop,
            tiles[0].size, tiles[0].size);

        if (tiles[0].position.top < screenSize.height * (tiles[0].size * 2) &&
            tiles[0].position.top > (tiles[0].size * -2)) {
          tiles.forEach((tile) {
            if (lastTile != null) {
              tile.position = lastTile.position.translate(lastTile.size, 0);
            }

            if (tile.position.left < screenSize.width + (tile.size * 2) &&
                tile.position.left > (tile.size * -2)) {
              if (tile.spriteImg.isNotEmpty)
                tilesMap.add(tile);

              if (tile.collision) {
                collisionsRect.add(tile.position);
              }

              if (tile.enemy != null) {
                tile.enemy.setInitPosition(tile.position);
                if(!enemies.contains(tile.enemy)){
                  enemies.add(tile.enemy);
                }
              }

              if (tile.decoration != null) {
                tile.decoration.setPosition(tile.position);
                decorations.add(tile.decoration);
              }
            }

            lastTile = tile;
          });
        }
        countY++;
      });
    }

    decorations.forEach((d)=> d.update(t));
    enemies.forEach((enemy) => enemy.updateEnemy(t, player, paddingLeft, paddingTop, collisionsRect));
    player.updatePlayer(t, collisionsRect, enemies, decorations);

  }

  void moveRight(double displacement) {
    if ((paddingLeft * -1) < maxLeft) {
      maxRight = false;
      paddingLeft = paddingLeft - displacement;
    } else {
      maxRight = true;
    }
  }

  void moveBottom(double displacement) {
    if ((paddingTop * -1) < maxTop) {
      maxBottom = false;
      paddingTop = paddingTop - displacement;
    } else {
      maxBottom = true;
    }
  }

  void moveLeft(double displacement) {
    if (paddingLeft < 0) {
      paddingLeft = paddingLeft + displacement;
      if(paddingLeft > 0){
        paddingLeft = 0;
      }
    } else {
      maxRight = false;
    }
  }

  void moveTop(double displacement) {
    if (paddingTop < 0) {
      paddingTop = paddingTop + displacement;
      if(paddingTop > 0){
        paddingTop = 0;
      }
    } else {
      maxBottom = false;
    }
  }

  bool isMaxTop() {
    return paddingTop == 0;
  }

  bool isMaxLeft() {
    return paddingLeft == 0;
  }

  bool isMaxRight() {
    return (paddingLeft * -1) >= maxLeft;
  }

  bool isMaxBottom() {
    return (paddingTop * -1) >= maxTop;
  }

  @override
  void resetMap(List<List<TileMap>> map) {
    this.map.forEach((item){
      item.forEach((i){
        if(i.enemy != null) {
          i.enemy.destroy();
        }
      });
    });
    enemies.clear();
    _lastPaddingTop = -1;
    _lastPaddingLeft = -1;
    paddingLeft = 0;
    paddingTop = 0;

    this.map = map;
    inicializeMap();
  }

  void _confInitialCamera() {
    if(player.position.left > screenSize.width / 2){
      paddingLeft = player.position.left - screenSize.width / 2;
      paddingLeft = paddingLeft *-1;
      if(paddingLeft > 0){
        paddingLeft = 0;
      }

      player.position = Rect.fromLTWH(
          screenSize.width / 2,
          player.position.top,
          player.position.width,
          player.position.height
      );
    }

    if(player.position.top > screenSize.height / 2){
      paddingTop = player.position.top - screenSize.height / 2;
      paddingTop = paddingTop *-1;
      if(paddingTop > 0){
        paddingTop = 0;
      }
      player.position = Rect.fromLTWH(
          player.position.left,
          screenSize.height / 2,
          player.position.width,
          player.position.height
      );
    }
  }

}
