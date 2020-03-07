import 'dart:ui';

import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/player/player.dart';

extension EnemyExtensions on Enemy {
  void seePlayer({Function(Player) observed, int visionCells = 3}) {
    Player player = gameRef.player;
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

  void seeAndMoveToPlayer({Function(Player) closePlayer, int visionCells = 3}) {
    if (!isVisibleInMap() || isDie) return;
    idle();
    seePlayer(
        visionCells: visionCells,
        observed: (player) {
          double centerXPlayer = player.position.center.dx;
          double centerYPlayer = player.position.center.dy;

          double translateX = 0;
          double translateY = 0;

          translateX =
              position.center.dx > centerXPlayer ? (-1 * speed) : speed;
          translateY =
              position.center.dy > centerYPlayer ? (-1 * speed) : speed;

          if ((translateX < 0 && translateX > -0.1) ||
              (translateX > 0 && translateX < 0.1)) {
            translateX = 0;
          }

          if ((translateY < 0 && translateY > -0.1) ||
              (translateY > 0 && translateY < 0.1)) {
            translateY = 0;
          }

          if (translateX == 0 && translateY == 0) {
            return;
          }

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

          if (position.overlaps(player.position)) {
            if (closePlayer != null) closePlayer(player);
            return;
          }

          if (collisionAll && collisionX && collisionY) {
            idle();
            return;
          }

          if (!collisionAll && !collisionX && !collisionY) {
            if (translateX > 0) {
              moveRight(moveSpeed: translateX);
            } else {
              moveLeft(moveSpeed: (translateX * -1));
            }
            if (translateY > 0) {
              moveBottom(moveSpeed: translateY);
            } else {
              moveTop(moveSpeed: (translateY * -1));
            }
          } else {
            if (!collisionX) {
              if (translateX > 0) {
                moveRight(moveSpeed: translateX);
              } else {
                moveLeft(moveSpeed: (translateX * -1));
              }
            }

            if (!collisionY) {
              if (translateY > 0) {
                moveBottom(moveSpeed: translateY);
              } else {
                moveTop(moveSpeed: (translateY * -1));
              }
            }
          }
        });
  }
}
