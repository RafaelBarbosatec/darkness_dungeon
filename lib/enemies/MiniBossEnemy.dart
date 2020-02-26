import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:darkness_dungeon/core/Util.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class MiniBossEnemy extends Enemy {
  static const double DAMAGE = 6;

  MiniBossEnemy()
      : super(
            FlameAnimation.Animation.sequenced("mini_boss_idle.png", 4,
                textureWidth: 16, textureHeight: 24),
            animationMoveRight: FlameAnimation.Animation.sequenced(
                "mini_boss_run_right.png", 4,
                textureWidth: 16, textureHeight: 24),
            animationMoveLeft: FlameAnimation.Animation.sequenced(
                "mini_boss_run_left.png", 4,
                textureWidth: 16, textureHeight: 24),
            animationDie: FlameAnimation.Animation.sequenced(
                "enemy_explosin.png", 5,
                textureWidth: 16, textureHeight: 16),
            width: 16,
            height: 24,
            life: 50,
            intervalAtack: 1000,
            speed: 1.2,
            visionCells: 4);

  @override
  void updateEnemy(double t, Player player, double mapPaddingLeft,
      double mapPaddingTop, List<Rect> collisionsMap) {
    moveToHero(player, () {
      player.receiveAttack(randomic(DAMAGE));
    });

    super.updateEnemy(t, player, mapPaddingLeft, mapPaddingTop, collisionsMap);
  }
}
