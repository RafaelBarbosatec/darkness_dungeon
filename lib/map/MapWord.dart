import 'package:darkness_dungeon/map/TileMap.dart';
import 'package:darkness_dungeon/map/TileMapConfig.dart';
import 'package:flutter/material.dart';

class MapWord {
  final List<List<TileMap>> map;
  final Size screenSize;

  double paddingLeft = 0;
  double paddingTop = 0;
  double maxTop = 0;
  double maxLeft = 0;
  bool maxRight = false;
  bool maxBottom = false;
  List<TileMap> collisions = List();
  Rect player;

  MapWord(this.map, this.screenSize) {
    maxTop = (map.length * TileMapConfig.size) - screenSize.height;
    map.forEach((list) {
      if (list.length > maxLeft) {
        maxLeft = list.length.toDouble();
      }
      collisions.addAll(list.where((i) => i.collision).toList());
    });
    maxLeft = maxLeft * TileMapConfig.size - screenSize.width;
  }

  void render(Canvas canvas) {
    int countY = 0;
    map.forEach((tiles) {
      TileMap lastTile;
      tiles[0].position = Rect.fromLTWH(paddingLeft,
          (countY * 16).toDouble() + paddingTop, tiles[0].size, tiles[0].size);

      if (tiles[0].position.top < screenSize.height &&
          tiles[0].position.top > (tiles[0].size * -1)) {
        tiles.forEach((tile) {
          if (lastTile != null) {
            tile.position = lastTile.position.translate(16, 0);
          }
          if (tile.position.left < screenSize.width &&
              tile.position.left > (tile.size * -1)) {
            tile.render(canvas);
            if (tile.enemy != null) {
              tile.enemy.position = tile.position;
              tile.enemy.render(canvas);
            }
          }
          lastTile = tile;
          // lastTile = tile;
        });
      }
      countY++;
    });
  }

  void update(double t) {
    map.forEach((list) {
      list.forEach((item) {
        if (item.enemy != null) {
          item.enemy.update(t);
        }
      });
    });
  }

  bool verifyCollisions(Rect player) {
    this.player = player;
    bool co = false;
    collisions.forEach((item) {
      Rect comp = Rect.fromLTWH(player.left, player.top + (player.height / 2),
          player.width / 1.5, player.height / 3);
      if (item.position.overlaps(comp)) {
        co = true;
      }
    });
    return co;
  }

  void moveRight() {
    if ((paddingLeft * -1) < maxLeft) {
      maxRight = false;
      paddingLeft = paddingLeft - 10;
    } else {
      maxRight = true;
    }
  }

  void moveBottom() {
    if ((paddingTop * -1) < maxTop) {
      maxBottom = false;
      paddingTop = paddingTop - 10;
    } else {
      maxBottom = true;
    }
  }

  void moveLeft() {
    if (paddingLeft < 0) {
      paddingLeft = paddingLeft + 10;
    } else {
      maxRight = false;
    }
  }

  void moveTop() {
    if (paddingTop < 0) {
      paddingTop = paddingTop + 10;
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
}
