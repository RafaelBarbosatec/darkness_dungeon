import 'package:darkness_dungeon/enemy/Enemy.dart';
import 'package:flutter/material.dart';

import 'package:flame/animation.dart' as FlameAnimation;

class SmileEnemy extends Enemy{

  SmileEnemy(){
    life = 20;
    size = 20;
    visionCells = 3;
    position = Rect.fromLTWH(0, 0, size, size);
    animation = FlameAnimation.Animation.sequenced(
    "slime_idle.png",
    6,
    textureWidth: 16,
    textureHeight: 16);
  }

  @override
  void updateEnemy(double t, Rect player) {

    moveToHero(player, (){
      _enemyAttack();
    });

    super.updateEnemy(t, player);
  }

  void _enemyAttack() {
    map.atackPlayer(10);
  }

}