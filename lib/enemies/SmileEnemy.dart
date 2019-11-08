import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:flutter/material.dart';

import 'package:flame/animation.dart' as FlameAnimation;

class SmileEnemy extends Enemy{

  static const double SIZE = 20;

  SmileEnemy():super(
      FlameAnimation.Animation.sequenced("slime_idle.png", 6, textureWidth: 16, textureHeight: 16),
      size: SIZE,
      life: 20,
      visionCells: 3,
  );

  @override
  void updateEnemy(double t, Rect player) {

    moveToHero(player, (){
      atackPlayer(10);
    });

    super.updateEnemy(t, player);
  }

}