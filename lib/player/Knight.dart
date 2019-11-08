import 'package:darkness_dungeon/core/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Knight extends Player {

  static const double SIZE = 25;
  final Function callBackdie;
  final double initX;
  final double initY;
  final Function(double) changeLife;

  Knight(Size screenSize, {this.callBackdie, this.changeLife,this.initX = 0.0, this.initY = 0.0}):super(
      screenSize,
      Rect.fromLTWH(initX - SIZE, initY - SIZE, SIZE, SIZE),
      FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16),
      life: 100,
      speedPlayer:2,
      changeLife:changeLife,
      callBackdie: callBackdie,
      animationMoveRight: FlameAnimation.Animation.sequenced("knight_run.png", 6, textureWidth: 16, textureHeight: 16),
      animationMoveTop: FlameAnimation.Animation.sequenced("knight_run.png", 6, textureWidth: 16, textureHeight: 16),
      animationMoveBottom: FlameAnimation.Animation.sequenced("knight_run.png", 6, textureWidth: 16, textureHeight: 16),
      animationMoveLeft: FlameAnimation.Animation.sequenced("knight_run_left.png" , 6, textureWidth: 16, textureHeight: 16),
      animationDie: FlameAnimation.Animation.sequenced("crypt.png" , 1, textureWidth: 16, textureHeight: 16)
  );

}
