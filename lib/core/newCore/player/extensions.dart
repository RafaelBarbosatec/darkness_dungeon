import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object_once.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/player/new_player.dart';
import 'package:flame/animation.dart' as FlameAnimation;

extension EnemyExtensions on NewPlayer {
  void simpleAttackMelee(
    double damage, {
    FlameAnimation.Animation attackRightAnim,
    FlameAnimation.Animation attackBottomAnim,
    FlameAnimation.Animation attackLeftAnim,
    FlameAnimation.Animation attackTopAnim,
  }) {
    Rect positionAttack;
    FlameAnimation.Animation anim = attackRightAnim;
    double pushLeft = 0;
    double pushTop = 0;
    switch (lastDirectional) {
      case Directional.MOVE_TOP:
        positionAttack =
            Rect.fromLTWH(position.left, position.top - size, size, size);
        anim = attackTopAnim;
        pushTop = size * -1;
        break;
      case Directional.MOVE_TOP_LEFT:
        break;
      case Directional.MOVE_TOP_RIGHT:
        break;
      case Directional.MOVE_RIGHT:
        positionAttack =
            Rect.fromLTWH(position.left + size, position.top, size, size);
        anim = attackRightAnim;
        pushLeft = size;
        break;
      case Directional.MOVE_BOTTOM:
        positionAttack =
            Rect.fromLTWH(position.left, position.top + size, size, size);
        anim = attackBottomAnim;
        pushTop = size;
        break;
      case Directional.MOVE_BOTTOM_RIGHT:
        break;
      case Directional.MOVE_BOTTOM_LEFT:
        break;
      case Directional.MOVE_LEFT:
        positionAttack =
            Rect.fromLTWH(position.left - size, position.top, size, size);
        anim = attackLeftAnim;
        pushLeft = size * -1;
        break;
      case Directional.IDLE:
        break;
    }

    gameRef.add(AnimatedObjectOnce(animation: anim, position: positionAttack));

    gameRef.enemies.where((i) => i.isVisibleInMap()).forEach((enemy) {
      if (enemy.position.overlaps(positionAttack)) {
        enemy.receiveDamage(damage);
        enemy.translate(pushLeft, pushTop);
      }
    });
  }
}
