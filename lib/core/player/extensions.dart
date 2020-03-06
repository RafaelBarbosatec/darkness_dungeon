import 'dart:ui';

import 'package:darkness_dungeon/core/player/player.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;

extension EnemyExtensions on Player {
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
    switch (lastDirection) {
      case Direction.top:
        positionAttack =
            Rect.fromLTWH(position.left, position.top - size, size, size);
        anim = attackTopAnim;
        pushTop = size * -1;
        break;
      case Direction.right:
        positionAttack =
            Rect.fromLTWH(position.left + size, position.top, size, size);
        anim = attackRightAnim;
        pushLeft = size;
        break;
      case Direction.bottom:
        positionAttack =
            Rect.fromLTWH(position.left, position.top + size, size, size);
        anim = attackBottomAnim;
        pushTop = size;
        break;
      case Direction.left:
        positionAttack =
            Rect.fromLTWH(position.left - size, position.top, size, size);
        anim = attackLeftAnim;
        pushLeft = size * -1;
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
