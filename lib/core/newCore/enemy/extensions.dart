import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/enemy/new_enemy.dart';
import 'package:darkness_dungeon/core/newCore/player/new_player.dart';

extension EnemyExtensions on NewEnemy {
  void seePlayer({Function(NewPlayer) observed, int visionCells = 3}) {
    NewPlayer player = gameRef.player;
    if (player.isDie || !isVisibleInMap()) return;

    double visionWidth = position.width * visionCells * 2;
    double visionHeight = position.height * visionCells * 2;

    Rect fieldOfVision = Rect.fromLTWH(
      position.left - (visionWidth / 2),
      position.top - (visionHeight / 2),
      visionWidth,
      visionHeight,
    );

    if (fieldOfVision.overlaps(player.position)) {
      if (observed != null) observed(player);
    }
  }

  void seeAndMoveToPlayer({
    Function(NewPlayer) closePlayer,
    int visionCells = 3,
    VoidCallback moveRight,
    VoidCallback moveLeft,
    VoidCallback moveBottom,
    VoidCallback moveTop,
    VoidCallback idle,
  }) {
    if (!isVisibleInMap()) return;

    seePlayer(
        visionCells: visionCells,
        observed: (player) {
          double centerXPlayer = player.position.center.dx;
          double centerYPlayer = player.position.center.dy;

          double translateX =
              position.center.dx > centerXPlayer ? (-1 * speed) : speed;
          double translateY =
              position.center.dy > centerYPlayer ? (-1 * speed) : speed;

          if ((position.center.dx > centerXPlayer &&
                  position.center.dx - centerXPlayer < speed) ||
              (position.center.dx < centerXPlayer &&
                  centerXPlayer - position.center.dx < speed)) {
            translateX = 0;
          }

          if ((position.center.dy > centerYPlayer &&
                  position.center.dy - centerYPlayer < speed) ||
              position.center.dy < centerYPlayer &&
                  centerYPlayer - position.center.dy < speed) {
            translateY = 0;
          }

          if (translateX > 0) {
            if (moveRight != null) moveRight();
          } else if (translateX < 0) {
            if (moveLeft != null) moveLeft();
          } else if (translateY > 0) {
            if (moveBottom != null) moveBottom();
          } else if (translateY < 0) {
            if (moveTop != null) moveTop();
          } else {
            if (idle != null) idle();
          }

          Rect moveTo = positionInWorld.translate(
            translateX,
            translateY,
          );

          var collisionAll = isCollisionTranslate(
            position,
            translateX,
            translateY,
            gameRef,
          );
          var collisionX = isCollisionTranslate(
            position,
            translateX,
            0,
            gameRef,
          );
          var collisionY = isCollisionTranslate(
            position,
            0,
            translateY,
            gameRef,
          );

          if (collisionAll && collisionX && collisionY) {
            animation = animationIdle;
            return;
          }

          if (collisionAll && !collisionX) {
            moveTo = positionInWorld.translate(translateX, 0);
          }

          if (collisionAll && !collisionY) {
            moveTo = positionInWorld.translate(0, translateY);
          }

          positionInWorld = moveTo;

          if (position.overlaps(player.position)) {
            if (closePlayer != null) closePlayer(player);
          }
        });
  }
}
