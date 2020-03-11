import 'package:darkness_dungeon/core/decoration/decoration.dart';
import 'package:darkness_dungeon/core/rpg_game.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flutter/widgets.dart';

class FlyingAttackObject extends AnimatedObject with HasGameRef<RPGGame> {
  final FlameAnimation.Animation flyAnimation;
  final FlameAnimation.Animation destroyAnimation;
  final Direction direction;
  final double speed;
  final double damage;
  final double width;
  final double height;
  final Position initPosition;
  final bool damageInPlayer;
  final bool damageInEnemy;
  Rect positionInWorld;
  bool _firstUpdate = true;

  FlyingAttackObject({
    @required this.initPosition,
    @required this.flyAnimation,
    @required this.direction,
    @required this.width,
    @required this.height,
    this.destroyAnimation,
    this.speed = 1.5,
    this.damage = 1,
    this.damageInPlayer = true,
    this.damageInEnemy = true,
  }) {
    animation = flyAnimation;
  }

  @override
  void update(double dt) {
    if (_firstUpdate) {
      position = Rect.fromLTWH(initPosition.x - gameRef.mapCamera.x,
          initPosition.y - gameRef.mapCamera.y, width, height);
      positionInWorld = position;
      _firstUpdate = false;
    }
    if (_verifyCollision()) return;
    switch (direction) {
      case Direction.left:
        positionInWorld = positionInWorld.translate(speed * -1, 0);
        break;
      case Direction.right:
        positionInWorld = positionInWorld.translate(speed, 0);
        break;
      case Direction.top:
        positionInWorld = positionInWorld.translate(0, speed * -1);
        break;
      case Direction.bottom:
        positionInWorld = positionInWorld.translate(0, speed);
        break;
    }

    position = Rect.fromLTWH(
      positionInWorld.left + gameRef.mapCamera.x,
      positionInWorld.top + gameRef.mapCamera.y,
      width,
      height,
    );

    if (position.right > gameRef.size.width * 2 ||
        position.left < gameRef.size.width * -2 ||
        position.bottom > gameRef.size.height * 2 ||
        position.top < gameRef.size.height * -2) {
      remove();
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (position.top < (gameRef.size.height + height) &&
        position.top > (height * -1) &&
        position.left > (width * -1) &&
        position.left < (gameRef.size.width + width)) {
      super.render(canvas);
    }
  }

  bool _verifyCollision() {
    bool destroy = false;

    Rect rectCollision = Rect.fromLTWH(
      position.left,
      position.top + (height - height / 3),
      width,
      (height - height / 2),
    );

    var collisionsDecorations = List<GameDecoration>();
    var collisions = gameRef.map
        .getCollisionsRendered()
        .where((i) => i.collision && i.position.overlaps(rectCollision))
        .toList();

    if (gameRef.decorations != null) {
      collisionsDecorations = gameRef.decorations
          .where((i) => i.collision && i.position.overlaps(rectCollision))
          .toList();
    }

    destroy = collisions.length > 0 || collisionsDecorations.length > 0;

    if (damageInPlayer) {
      if (position.overlaps(gameRef.player.position)) {
        destroy = true;
        gameRef.player.receiveDamage(damage);
      }
    }

    if (damageInEnemy) {
      gameRef.enemies.where((i) => i.isVisibleInMap()).forEach((enemy) {
        if (enemy.position.overlaps(position)) {
          enemy.receiveDamage(damage);
          destroy = true;
        }
      });
    }

    if (destroy) {
      if (destroyAnimation != null) {
        Rect positionDestroy;
        switch (direction) {
          case Direction.left:
            positionDestroy = Rect.fromLTWH(
              position.left - width,
              position.top,
              width,
              height,
            );
            break;
          case Direction.right:
            positionDestroy = Rect.fromLTWH(
              position.left + width,
              position.top,
              width,
              height,
            );
            break;
          case Direction.top:
            positionDestroy = Rect.fromLTWH(
              position.left,
              position.top - height,
              width,
              height,
            );
            break;
          case Direction.bottom:
            positionDestroy = Rect.fromLTWH(
              position.left,
              position.top + height,
              width,
              height,
            );
            break;
        }

        gameRef.add(
          AnimatedObjectOnce(
            animation: destroyAnimation,
            position: positionDestroy,
          ),
        );
      }
      remove();
    }

    return destroy;
  }
}
