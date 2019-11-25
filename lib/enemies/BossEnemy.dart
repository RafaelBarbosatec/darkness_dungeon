import 'dart:math';

import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class BossEnemy extends Enemy{

  static const double DAMAGE = 5;

  BossEnemy():super(
      FlameAnimation.Animation.sequenced("boss_idle.png", 4, textureWidth: 32, textureHeight: 36),
      animationDie: FlameAnimation.Animation.sequenced("enemy_explosin.png", 5, textureWidth: 16, textureHeight: 16),
      width:32,
      height:36,
      life: 300,
      intervalAtack: 500,
      speed: 1.1,
      visionCells: 4
  );

  @override
  void updateEnemy(double t, Player player, double mapPaddingLeft, double mapPaddingTop, List<Rect> collisionsMap) {

    moveToHero(player, (){
      double damageMin = DAMAGE /2;
      int p = Random().nextInt(DAMAGE.toInt() + (damageMin.toInt()));
      double damage = damageMin + p;
      player.recieveAtack(damage);
    });

    super.updateEnemy(t, player,mapPaddingLeft,mapPaddingTop,collisionsMap);
  }

}