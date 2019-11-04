
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class TileDecoration{

  bool isSetPosition = false;
  double size = 16;
  final String spriteImg;
  Rect position;
  Sprite spriteTile;

  TileDecoration(this.spriteImg){
    position = Rect.fromLTWH(0,0, size, size);
    spriteTile = Sprite(spriteImg);
  }

  setInitPosition(Rect position){
    if(!isSetPosition){
      isSetPosition = true;
      this.position = position;
    }
  }

  void render(Canvas canvas) {
    spriteTile.renderRect(canvas, position);
  }

}