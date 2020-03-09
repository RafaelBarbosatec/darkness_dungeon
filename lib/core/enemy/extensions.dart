import 'dart:ui';

import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/flying_attack_object.dart';
import 'package:darkness_dungeon/core/player/player.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/widgets.dart';

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

  void simpleAttackMelee(
    double damage, {
    double heightArea = 32,
    double widthArea = 32,
    FlameAnimation.Animation attackEffectRightAnim,
    FlameAnimation.Animation attackEffectBottomAnim,
    FlameAnimation.Animation attackEffectLeftAnim,
    FlameAnimation.Animation attackEffectTopAnim,
  }) {
    Player player = gameRef.player;
    if (player.isDie || !isVisibleInMap()) return;

    Rect positionAttack;
    FlameAnimation.Animation anim = attackEffectRightAnim;

    Direction playerDirection;

    double centerXPlayer = player.position.center.dx;
    double centerYPlayer = player.position.center.dy;

    double centerYEnemy = position.center.dy;
    double centerXEnemy = position.center.dx;

    double diffX = centerXEnemy - centerXPlayer;
    double diffY = centerYEnemy - centerYPlayer;

    double positiveDiffX = diffX > 0 ? diffX : diffX * -1;
    double positiveDiffY = diffY > 0 ? diffY : diffY * -1;
    if (positiveDiffX > positiveDiffY) {
      playerDirection = diffX > 0 ? Direction.left : Direction.right;
    } else {
      playerDirection = diffY > 0 ? Direction.top : Direction.bottom;
    }

    switch (playerDirection) {
      case Direction.top:
        positionAttack = Rect.fromLTWH(
            position.left, position.top - heightArea, widthArea, heightArea);
        if (attackEffectTopAnim != null) anim = attackEffectTopAnim;
        break;
      case Direction.right:
        positionAttack = Rect.fromLTWH(
            position.left + widthArea, position.top, widthArea, heightArea);
        if (attackEffectRightAnim != null) anim = attackEffectRightAnim;
        break;
      case Direction.bottom:
        positionAttack = Rect.fromLTWH(
            position.left, position.top + heightArea, widthArea, heightArea);
        if (attackEffectBottomAnim != null) anim = attackEffectBottomAnim;
        break;
      case Direction.left:
        positionAttack = Rect.fromLTWH(
            position.left - widthArea, position.top, widthArea, heightArea);
        if (attackEffectLeftAnim != null) anim = attackEffectLeftAnim;
        break;
    }

    gameRef.add(AnimatedObjectOnce(animation: anim, position: positionAttack));

    player.receiveDamage(damage);
  }

  void simpleAttackRange({
    @required FlameAnimation.Animation animationRight,
    @required FlameAnimation.Animation animationLeft,
    @required FlameAnimation.Animation animationTop,
    @required FlameAnimation.Animation animationBottom,
    @required FlameAnimation.Animation animationDestroy,
    @required double width,
    @required double height,
    double speed = 1.5,
    double damage = 1,
    Direction direction,
  }) {
    if (isDie) return;

    Position startPosition;
    FlameAnimation.Animation attackRangeAnimation;

    Direction d = direction != null ? direction : this.lastDirection;
    switch (d) {
      case Direction.left:
        if (animationLeft != null) attackRangeAnimation = animationLeft;
        startPosition = Position(
          this.position.left - width,
          (this.position.top + (this.position.height - height) / 2),
        );
        break;
      case Direction.right:
        if (animationRight != null) attackRangeAnimation = animationRight;
        startPosition = Position(
          this.position.right,
          (this.position.top + (this.position.height - height) / 2),
        );
        break;
      case Direction.top:
        if (animationTop != null) attackRangeAnimation = animationTop;
        startPosition = Position(
          (this.position.left + (this.position.width - width) / 2),
          this.position.top - height,
        );
        break;
      case Direction.bottom:
        if (animationBottom != null) attackRangeAnimation = animationBottom;
        startPosition = Position(
          (this.position.left + (this.position.width - width) / 2),
          this.position.bottom,
        );
        break;
    }

    gameRef.add(
      FlyingAttackObject(
        direction: d,
        flyAnimation: attackRangeAnimation,
        destroyAnimation: animationDestroy,
        initPosition: startPosition,
        height: height,
        width: width,
        damage: damage,
        speed: speed,
        damageInEnemy: false,
      ),
    );
  }
}
