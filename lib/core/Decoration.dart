
import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class TileDecoration extends AnimationGameObject{

  bool isSetPosition = false;
  final double size;
  final String spriteImg;
  final bool frontFromPlayer;
  final FlameAnimation.Animation animation;
  Rect position;
  Sprite spriteTile;

  TileDecoration(this.spriteImg, {this.size = 16, this.frontFromPlayer = false, this.animation}){
    this.animation = animation;
    position = Rect.fromLTWH(0,0, size, size);
    if(spriteImg.isNotEmpty)
      spriteTile = Sprite(spriteImg);
  }

  setPosition(Rect position){
    this.position = Rect.fromLTWH(position.left, position.top, this.position.width, this.position.height);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(spriteTile != null)
      spriteTile.renderRect(canvas, position);
  }
}