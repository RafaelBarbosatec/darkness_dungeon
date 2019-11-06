import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:flutter/material.dart';

import 'package:flame/animation.dart' as FlameAnimation;

class SmileEnemy extends Enemy{

  SmileEnemy():super(size: 20,life: 20,visionCells: 3){
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
    atackPlayer(10);
  }

}