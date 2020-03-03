import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/new_object_collision.dart';
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
  Rect _positionCurrent;

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
    _positionCurrent = this.position;
  }

  @override
  void render(Canvas canvas) {
    if (position.top < (gameRef.size.height + height) &&
        position.top > (height * -1) &&
        position.left > (width * -1) &&
        position.left < (gameRef.size.width + width)) {
      if (drawDefaultLife) {
        _drawLife(canvas);
      }
      super.render(canvas);
    }
  }

  @override
  void update(double dt) {
    position = Rect.fromLTWH(
      _positionCurrent.left + gameRef.mapCamera.x,
      _positionCurrent.top + gameRef.mapCamera.y,
      width,
      height,
    );
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
}
