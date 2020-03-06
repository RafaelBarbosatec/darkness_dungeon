import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/new_object_collision.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:darkness_dungeon/core/newCore/enemy/extensions.dart';

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
  double maxLife;
  Rect positionInWorld;
  bool _isDie = false;

  NewEnemy({
    @required this.animationIdle,
    @required this.initPosition,
    @required this.height,
    @required this.width,
    this.sizeTileMap = 32,
    this.speed = 3,
    this.life = 10,
    this.drawDefaultLife = true,
  }) {
    maxLife = life;
    animation = animationIdle;
    this.position = Rect.fromLTWH(
      initPosition.x * sizeTileMap,
      initPosition.y * sizeTileMap,
      width,
      height,
    );
    positionInWorld = this.position;
    widthCollision = width;
    heightCollision = height / 3;
  }

  bool get isDie => _isDie;

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
    position = _currentToRealPosition(positionInWorld);
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

    double currentBarLife = (life * width) / maxLife;

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
      position.left < (gameRef.size.width + width) &&
      !destroy();

  Rect _currentToRealPosition(Rect currentPosition) {
    return Rect.fromLTWH(
      positionInWorld.left + gameRef.mapCamera.x,
      positionInWorld.top + gameRef.mapCamera.y,
      width,
      height,
    );
  }

  void translate(double translateX, double translateY) {
    positionInWorld = positionInWorld.translate(translateX, translateY);
  }

  void receiveDamage(double damage) {
    if (life > 0) {
      life -= damage;
      if (life <= 0) {
        die();
      }
    }
  }

  void die() {
    _isDie = true;
  }
}
