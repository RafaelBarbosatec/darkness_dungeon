import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/map/TileMap.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:flutter/material.dart';

abstract class MapGame {

  double paddingLeft = 0;
  double paddingTop = 0;

  bool verifyCollision(Rect rect);

  void moveRight(double displacement);

  void moveBottom(double displacement);

  void moveLeft(double displacement);

  void moveTop(double displacement);

  bool isMaxTop();

  bool isMaxLeft();

  bool isMaxRight();

  bool isMaxBottom();

  void atackPlayer(double damage);
}

class MapWord implements MapGame {
  final List<List<TileMap>> map;
  final Size screenSize;
  final Player player;

  double paddingLeft = 0;
  double paddingTop = 0;
  double maxTop = 0;
  double maxLeft = 0;
  bool maxRight = false;
  bool maxBottom = false;
  List<TileMap> collisions = List();
  List<Enemy> enemies = List();

  MapWord(this.map,this.player, this.screenSize) {
    player.map = this;
    if(map.isNotEmpty && map[0].isNotEmpty) {
      maxTop = (map.length * map[0][0].size) - screenSize.height;
      map.forEach((list) {
        if (list.length > maxLeft) {
          maxLeft = list.length.toDouble();
        }
        collisions.addAll(list.where((i) => i.collision).toList());

        var en = list.where((i) => i.enemy != null).toList();
        en.forEach((item) {
          enemies.add(item.enemy);
        });
      });
      maxLeft = maxLeft * map[0][0].size - screenSize.width;
    }
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
          if (tile.position.left < screenSize.width + tile.size &&
              tile.position.left > (tile.size * -1)) {
            tile.render(canvas);
            if (tile.enemy != null) {
              tile.enemy.setMap(this);
              Rect initEnemyPosition = Rect.fromLTWH(tile.position.left, tile.position.top, tile.enemy.position.width, tile.enemy.position.height);
              tile.enemy.setInitPosition(initEnemyPosition);
            }
            if (tile.decoration != null) {
              Rect initDecorationPosition = Rect.fromLTWH(tile.position.left, tile.position.top, tile.decoration.position.width, tile.decoration.position.height);
              tile.decoration.position = initDecorationPosition;
              tile.decoration.render(canvas);
            }
          }
          lastTile = tile;
          // lastTile = tile;
        });
      }
      countY++;
    });

    enemies.forEach((enemy) {
      Rect positionFromMap = Rect.fromLTWH(
          enemy.position.left + paddingLeft,
          enemy.position.top + paddingTop,
          enemy.position.width,
          enemy.position.height);

      if ((positionFromMap.left < screenSize.width + positionFromMap.width &&
              positionFromMap.left > (positionFromMap.width * -1)) &&
          (positionFromMap.top < screenSize.height + positionFromMap.height &&
              positionFromMap.top > (positionFromMap.height * -1))) {
        enemy.renderRect(canvas, positionFromMap);
      }
    });

    player.render(canvas);
  }

  void update(double t) {
    map.forEach((list) {
      list.forEach((item) {
        if (item.enemy != null) {
          item.enemy.updateEnemy(t, player.position);
        }
      });
    });
    player.update(t);
  }

  @override
  bool verifyCollision(Rect rect) {
    bool co = false;
    collisions.forEach((item) {
      Rect comp = Rect.fromLTWH(rect.left, rect.top + (rect.height / 2),
          rect.width / 1.5, rect.height / 3);
      if (item.position.overlaps(comp)) {
        co = true;
      }
    });
    return co;
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
  void atackPlayer(double damage) {
    player.recieveAtack(damage);
  }
}
