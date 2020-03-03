import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/new_object_collision.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewEnemy extends AnimatedObject
    with NewObjectCollision, HasGameRef<RPGGame> {
  final FlameAnimation.Animation animationIdle;
  final double speed;
  final double height;
  final double width;
  final double sizeTileMap;
  final Position initPosition;
  final bool drawDefaultLife;
  double life;
  double _maxLife;
  Rect _currentPosition;

  NewEnemy({
    @required this.animationIdle,
    @required this.initPosition,
    this.sizeTileMap = 32,
    this.speed = 3,
    this.height,
    this.width,
    this.life = 10,
    this.drawDefaultLife = true,
  }) {
    _maxLife = life;
    animation = animationIdle;
    this.position = Rect.fromLTWH(
      initPosition.x * sizeTileMap,
      initPosition.y * sizeTileMap,
      width,
      height,
    );
    _currentPosition = this.position;
    widthCollision = width;
    heightCollision = height / 3;
  }

  @override
  void render(Canvas canvas) {
    if (isVisibleInMap()) {
      if (drawDefaultLife) {
        _drawLife(canvas);
      }
      super.render(canvas);
    }
  }

  @override
  void update(double dt) {
    position = _currentToRealPosition(_currentPosition);
    super.update(dt);
  }

  void _drawLife(Canvas canvas) {
    canvas.drawLine(
        Offset(position.left, position.top - 4),
        Offset(position.left + width, position.top - 4),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * width) / _maxLife;

    canvas.drawLine(
        Offset(position.left, position.top - 4),
        Offset(position.left + currentBarLife, position.top - 4),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = 2
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > width - (width / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (width / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  bool isVisibleInMap() =>
      position.top < (gameRef.size.height + height) &&
      position.top > (height * -1) &&
      position.left > (width * -1) &&
      position.left < (gameRef.size.width + width);

  void seeAndMoveToPlayer(
      {Function(NewPlayer) closePlayer, double visionCells = 3}) {
    if (!isVisibleInMap()) {
      return;
    }

    NewPlayer player = gameRef.player;

    double visionWidth = position.width * visionCells * 2;
    double visionHeight = position.height * visionCells * 2;
    Rect fieldOfVision = Rect.fromLTWH(position.left - (visionWidth / 2),
        position.top - (visionHeight / 2), visionWidth, visionHeight);

    //CALCULA CENTRO DO PLAYER
    double leftPlayer = player.position.center.dx;
    double topPlayer = player.position.center.dy;

    if (fieldOfVision.overlaps(player.position)) {
      double translateX =
          position.center.dx > leftPlayer ? (-1 * speed) : speed;
      double translateY = position.center.dy > topPlayer ? (-1 * speed) : speed;

      if (translateX > 0) {
        //animToRight();
      } else if (translateX < 0) {
        //animToLeft();
      } else if (translateY > 0) {
        // animToBottom();
      } else if (translateY < 0) {
        //animToTop();
      } else {
        //idle();
      }

      Rect moveTo = _currentPosition.translate(
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
        moveTo = _currentPosition.translate(translateX, 0);
      }

      if (collisionAll && !collisionY) {
        moveTo = _currentPosition.translate(0, translateY);
      }

      _currentPosition = moveTo;

      if (position.overlaps(player.position)) {
        if (closePlayer != null) closePlayer(player);
      }
    }
  }

  Rect _currentToRealPosition(Rect currentPosition) {
    return Rect.fromLTWH(
      _currentPosition.left + gameRef.mapCamera.x,
      _currentPosition.top + gameRef.mapCamera.y,
      width,
      height,
    );
  }
}
