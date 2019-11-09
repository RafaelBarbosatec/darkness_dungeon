
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class TileDecoration{

  bool isSetPosition = false;
  final double size;
  final String spriteImg;
  final bool frontFromPlayer;
  Rect position;
  Sprite spriteTile;

  TileDecoration(this.spriteImg, {this.size = 16, this.frontFromPlayer = false}){
    position = Rect.fromLTWH(0,0, size, size);
    spriteTile = Sprite(spriteImg);
  }

  setPosition(Rect position){
    this.position = Rect.fromLTWH(position.left, position.top, this.position.width, this.position.height);
  }

  void render(Canvas canvas) {
    spriteTile.renderRect(canvas, position);
  }

}