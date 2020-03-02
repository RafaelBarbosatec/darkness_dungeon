import 'dart:ui';

import 'package:darkness_dungeon/core/map/map_game.dart';
import 'package:darkness_dungeon/core/map/tile.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

class NewMapWorld extends MapGame with HasGameRef<RPGGame> {
  double maxTop = 0;
  double maxLeft = 0;
  bool maxRight = false;
  bool maxBottom = false;
  double lastCameraX = -1;
  double lastCameraY = -1;
  List<Tile> tilesToRender = List();

  NewMapWorld(List<List<Tile>> map) : super(map);

  void verifyMaxTopAndLeft() {
    if (maxLeft == 0 || maxTop == 0) {
      if (map.isNotEmpty && map[0].isNotEmpty) {
        maxTop = (map.length * map[0][0].size) - gameRef.size.height;
        map.forEach((list) {
          if (list.length > maxLeft) {
            maxLeft = list.length.toDouble();
          }
        });

        maxLeft = maxLeft * map[0][0].size - gameRef.size.width;
      }
    }
  }

  @override
  bool isMaxBottom() {
    return (gameRef.mapCamera.y * -1) >= maxTop;
  }

  @override
  bool isMaxLeft() {
    return gameRef.mapCamera.x == 0;
  }

  @override
  bool isMaxRight() {
    return (gameRef.mapCamera.x * -1) >= maxLeft;
  }

  @override
  bool isMaxTop() {
    return gameRef.mapCamera.y == 0;
  }

  @override
  void moveCamera(double displacement, Directional directional) {
    switch (directional) {
      case Directional.MOVE_TOP:
        if (gameRef.mapCamera.y > 0) {
          gameRef.mapCamera.y = 0;
        }
        if (gameRef.mapCamera.y < 0) {
          gameRef.mapCamera.y = gameRef.mapCamera.y + displacement;
        }
        break;
      case Directional.MOVE_RIGHT:
        if (!isMaxRight()) {
          maxRight = false;
          gameRef.mapCamera.x = gameRef.mapCamera.x - displacement;
        }
        break;
      case Directional.MOVE_BOTTOM:
        if (!isMaxBottom()) {
          gameRef.mapCamera.y = gameRef.mapCamera.y - displacement;
        }
        break;
      case Directional.MOVE_LEFT:
        if (gameRef.mapCamera.x > 0) {
          gameRef.mapCamera.x = 0;
        }
        if (!isMaxLeft()) {
          gameRef.mapCamera.x = gameRef.mapCamera.x + displacement;
        }
        break;
      case Directional.MOVE_TOP_LEFT:
        break;
      case Directional.MOVE_TOP_RIGHT:
        break;
      case Directional.MOVE_BOTTOM_RIGHT:
        break;
      case Directional.MOVE_BOTTOM_LEFT:
        break;
      case Directional.IDLE:
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    tilesToRender.forEach((tile) => tile.render(canvas));
  }

  @override
  void resetMap(List<List<Tile>> map) {}

  @override
  void update(double t) {
    verifyMaxTopAndLeft();
    if (lastCameraX != gameRef.mapCamera.x ||
        gameRef.mapCamera.y != lastCameraY) {
      lastCameraX = gameRef.mapCamera.x;
      lastCameraY = gameRef.mapCamera.y;

      int countY = 0;
      tilesToRender.clear();
      map.forEach((tiles) {
        Tile lastTile;
        tiles[0].position = Rect.fromLTWH(
            gameRef.mapCamera.x,
            (countY * tiles[0].size).toDouble() + gameRef.mapCamera.y,
            tiles[0].size,
            tiles[0].size);

        if (tiles[0].position.top < gameRef.size.height + tiles[0].size &&
            tiles[0].position.top > tiles[0].size * -1) {
          tiles.forEach((tile) {
            if (lastTile != null) {
              tile.position = lastTile.position.translate(lastTile.size, 0);
            }

            if (tile.position.left < gameRef.size.width + (tile.size) &&
                tile.position.left > (tile.size * -1)) {
              if (tile.spriteImg.isNotEmpty) tilesToRender.add(tile);
            }

            lastTile = tile;
          });
        }
        countY++;
      });
    }
  }

  @override
  List<Tile> getRendered() {
    return tilesToRender;
  }
}
