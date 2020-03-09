import 'dart:async';

import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/player/player.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Goblin extends Enemy {
  final Position initPosition;
  final double sizeTileMap;
  double attack = 10;
  Timer _timerAttack;
  bool _closePlayer;

  Goblin({
    @required this.initPosition,
    this.sizeTileMap = 32,
  }) : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "goblin_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "goblin_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "goblin_run_right.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "goblin_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPosition: initPosition,
          sizeTileMap: sizeTileMap,
          width: 25,
          height: 25,
          speed: 1.5,
          life: 100,
        );

  @override
  void update(double dt) {
    _closePlayer = false;
    seeAndMoveToPlayer(
      visionCells: 5,
      closePlayer: (player) {
        _closePlayer = true;
        startTimeAttack(player);
      },
    );

    this.seePlayer(
        observed: (p) {
          Direction ballDirection;

          var diffX = position.center.dx - p.position.center.dx;
          var diffPositiveX = diffX < 0 ? diffX *= -1 : diffX;
          var diffY = position.center.dy - p.position.center.dy;
          var diffPositiveY = diffY < 0 ? diffY *= -1 : diffY;

          if (diffPositiveX > diffPositiveY) {
            if (p.position.center.dx > position.center.dx) {
              ballDirection = Direction.right;
            } else if (p.position.center.dx < position.center.dx) {
              ballDirection = Direction.left;
            }
          } else {
            if (p.position.center.dy > position.center.dy) {
              ballDirection = Direction.bottom;
            } else if (p.position.center.dy < position.center.dy) {
              ballDirection = Direction.top;
            }
          }

//          this.simpleAttackRange(
//            animationRight: FlameAnimation.Animation.sequenced(
//              'player/fireball_right.png',
//              3,
//              textureWidth: 23,
//              textureHeight: 23,
//            ),
//            animationLeft: FlameAnimation.Animation.sequenced(
//              'player/fireball_left.png',
//              3,
//              textureWidth: 23,
//              textureHeight: 23,
//            ),
//            animationTop: FlameAnimation.Animation.sequenced(
//              'player/fireball_top.png',
//              3,
//              textureWidth: 23,
//              textureHeight: 23,
//            ),
//            animationBottom: FlameAnimation.Animation.sequenced(
//              'player/fireball_bottom.png',
//              3,
//              textureWidth: 23,
//              textureHeight: 23,
//            ),
//            animationDestroy: FlameAnimation.Animation.sequenced(
//              'player/explosion_fire.png',
//              6,
//              textureWidth: 32,
//              textureHeight: 32,
//            ),
//            width: 25,
//            height: 25,
//            damage: 0,
//            speed: speed * 1.5,
//            direction: ballDirection,
//          );
        },
        visionCells: 10);
    super.update(dt);
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "enemy_explosin.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: position,
      ),
    );
    remove();
    super.die();
  }

  void startTimeAttack(Player player) {
    if (_timerAttack != null && _timerAttack.isActive) {
      return;
    }
    execAttack(player);
    _timerAttack = Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      if (_closePlayer) {
        execAttack(player);
      } else {
        _timerAttack.cancel();
      }
    });
  }

  void execAttack(Player player) {
    this.simpleAttackMelee(
      attack,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
    );
  }
}
