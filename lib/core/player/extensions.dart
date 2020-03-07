import 'dart:ui';

import 'package:darkness_dungeon/core/player/player.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;

extension PlayerExtensions on Player {
  void simpleAttackMelee(
    double damage, {
    double heightArea = 32,
    double widthArea = 32,
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
        positionAttack = Rect.fromLTWH(
            position.left, position.top - heightArea, widthArea, heightArea);
        anim = attackTopAnim;
        pushTop = heightArea * -1;
        break;
      case Direction.right:
        positionAttack = Rect.fromLTWH(
            position.left + widthArea, position.top, widthArea, heightArea);
        anim = attackRightAnim;
        pushLeft = widthArea;
        break;
      case Direction.bottom:
        positionAttack = Rect.fromLTWH(
            position.left, position.top + heightArea, widthArea, heightArea);
        anim = attackBottomAnim;
        pushTop = heightArea;
        break;
      case Direction.left:
        positionAttack = Rect.fromLTWH(
            position.left - widthArea, position.top, widthArea, heightArea);
        anim = attackLeftAnim;
        pushLeft = widthArea * -1;
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
