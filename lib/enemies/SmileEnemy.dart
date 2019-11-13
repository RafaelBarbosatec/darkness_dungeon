import 'dart:math';

import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:flutter/material.dart';

import 'package:flame/animation.dart' as FlameAnimation;

class SmileEnemy extends Enemy{

  static const double SIZE = 20;
  static const double DAMAGE = 10;

  SmileEnemy():super(
      FlameAnimation.Animation.sequenced("slime_idle.png", 6, textureWidth: 16, textureHeight: 16),
      size: SIZE,
      life: 50,
      visionCells: 3,
  );

  @override
  void updateEnemy(double t, Rect player) {

    moveToHero(player, (){
      double damageMin = DAMAGE /2;
      int p = Random().nextInt(DAMAGE.toInt() + (damageMin.toInt()));
      double damage = damageMin + p;
      atackPlayer(damage);
    });

    super.updateEnemy(t, player);
  }

}