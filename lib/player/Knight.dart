import 'package:darkness_dungeon/core/Player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class Knight extends Player {
  static const double SIZE = 25;
  final Function callBackDie;
  final double initX;
  final double initY;
  final Function(double) changeLife;
  final Function(double) changeStamina;

  Knight(Size screenSize,
      {this.callBackDie,
      this.changeLife,
      this.changeStamina,
      this.initX = 0.0,
      this.initY = 0.0})
      : super(
          SIZE,
          screenSize,
          Rect.fromLTWH(initX * SIZE, initY * SIZE, SIZE, SIZE),
          FlameAnimation.Animation.sequenced("knight_idle.png", 6,
              textureWidth: 16, textureHeight: 16),
          damageAttack: 10,
          life: 100,
          speedPlayer: 2,
          changeLife: changeLife,
          changeStamina: changeStamina,
          callBackDie: callBackDie,
          animationIdleLeft: FlameAnimation.Animation.sequenced(
              "knight_idle_left.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationMoveRight: FlameAnimation.Animation.sequenced(
              "knight_run.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationMoveTop: FlameAnimation.Animation.sequenced(
              "knight_run.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationMoveBottom: FlameAnimation.Animation.sequenced(
              "knight_run.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationMoveLeft: FlameAnimation.Animation.sequenced(
              "knight_run_left.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationDie: FlameAnimation.Animation.sequenced("crypt.png", 1,
              textureWidth: 16, textureHeight: 16),
          animationAttackLeft: FlameAnimation.Animation.sequenced(
              "atack_effect_left.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationAttackRight: FlameAnimation.Animation.sequenced(
              "atack_effect_right.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationAttackTop: FlameAnimation.Animation.sequenced(
              "atack_effect_top.png", 6,
              textureWidth: 16, textureHeight: 16),
          animationAttackBottom: FlameAnimation.Animation.sequenced(
              "atack_effect_bottom.png", 6,
              textureWidth: 16, textureHeight: 16),
        );
}
