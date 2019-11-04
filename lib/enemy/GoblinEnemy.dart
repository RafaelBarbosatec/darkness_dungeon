
import 'package:darkness_dungeon/enemy/Enemy.dart';
import 'package:darkness_dungeon/map/TileMap.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class GoblinEnemy extends Enemy{

  static double size = 25;

  GoblinEnemy(){
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
  void updateEnemy(double t, Rect player, List<TileMap> collisions,double paddingLeft, double paddingTop) {

    moveToHero(player, collisions, paddingLeft, paddingTop, (){
      _enemyAttack();
    });

    super.updateEnemy(t, player,collisions,paddingLeft,paddingTop);
  }

  void _enemyAttack() {

  }
}