
import 'package:darkness_dungeon/enemy/Enemy.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class GoblinEnemy extends Enemy{

  GoblinEnemy(){
    life = 30;
    size = 20;
    intervalAtack = 1000;
    position = Rect.fromLTWH(0, 0, size, size);
    animation = FlameAnimation.Animation.sequenced(
        "goblin_idle.png",
        6,
        textureWidth: 16,
        textureHeight: 16);
    speed = 1.2;
    visionCells = 6;
  }

  @override
  void updateEnemy(double t, Rect player) {

    moveToHero(player, (){
      _enemyAttack();
    });

    super.updateEnemy(t, player);
  }

  void _enemyAttack() {
    map.atackPlayer(30);
  }
}