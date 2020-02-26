import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:darkness_dungeon/core/Util.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class BossEnemy extends Enemy {
  static const double DAMAGE = 6;

  BossEnemy()
      : super(
            FlameAnimation.Animation.sequenced("boss_idle.png", 4,
                textureWidth: 32, textureHeight: 32),
            animationMoveRight: FlameAnimation.Animation.sequenced(
                "boos_run_right.png", 4, textureWidth: 32, textureHeight: 32),
            animationMoveLeft: FlameAnimation.Animation.sequenced(
                "boos_run_left.png", 4, textureWidth: 32, textureHeight: 32),
            animationDie: FlameAnimation.Animation.sequenced(
                "enemy_explosin.png", 5,
                textureWidth: 16, textureHeight: 16),
            width: 32,
            height: 32,
            life: 300,
            intervalAtack: 500,
            speed: 1.0,
            visionCells: 3);

  @override
  void updateEnemy(double t, Player player, double mapPaddingLeft,
      double mapPaddingTop, List<Rect> collisionsMap) {
    moveToHero(player, () {
      player.receiveAttack(randomic(DAMAGE));
    });

    super.updateEnemy(t, player, mapPaddingLeft, mapPaddingTop, collisionsMap);
  }
}
