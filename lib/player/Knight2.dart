import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object_once.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Knight2 extends NewPlayer {
  final double size;
  final Position initPosition;
  double attack = 20;

  Knight2({
    this.size,
    this.initPosition,
  }) : super(
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleRight: FlameAnimation.Animation.sequenced(
            "knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          size: size,
          initPosition: initPosition,
        ) {
    speed = 3;
    life = 200;
  }

  @override
  void joystickAction(int action) {
    super.joystickAction(action);
    if (action == 0) {
      execAttack(gameRef);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  void execAttack(RPGGame gameRef) {
    Rect positionAttack;
    String spriteAnim = "";
    double pushLeft = 0;
    double pushTop = 0;
    switch (lastDirectional) {
      case Directional.MOVE_TOP:
        positionAttack =
            Rect.fromLTWH(position.left, position.top - size, size, size);
        spriteAnim = "atack_effect_top.png";
        pushTop = size * -1;
        break;
      case Directional.MOVE_TOP_LEFT:
        // TODO: Handle this case.
        break;
      case Directional.MOVE_TOP_RIGHT:
        // TODO: Handle this case.
        break;
      case Directional.MOVE_RIGHT:
        positionAttack =
            Rect.fromLTWH(position.left + size, position.top, size, size);
        spriteAnim = "atack_effect_right.png";
        pushLeft = size;
        break;
      case Directional.MOVE_BOTTOM:
        positionAttack =
            Rect.fromLTWH(position.left, position.top + size, size, size);
        spriteAnim = "atack_effect_bottom.png";
        pushTop = size;
        break;
      case Directional.MOVE_BOTTOM_RIGHT:
        // TODO: Handle this case.
        break;
      case Directional.MOVE_BOTTOM_LEFT:
        // TODO: Handle this case.
        break;
      case Directional.MOVE_LEFT:
        positionAttack =
            Rect.fromLTWH(position.left - size, position.top, size, size);
        spriteAnim = "atack_effect_left.png";
        pushLeft = size * -1;
        break;
      case Directional.IDLE:
        // TODO: Handle this case.
        break;
    }

    gameRef.add(AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          spriteAnim,
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: positionAttack));

    gameRef.enemies.where((i) => i.isVisibleInMap()).forEach((enemy) {
      if (enemy.position.overlaps(positionAttack)) {
        enemy.life -= attack;
        if (enemy.life < 0) {
          enemy.life = 0;
        }
        enemy.translate(pushLeft, pushTop);
      }
    });
  }
}
