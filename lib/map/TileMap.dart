
import 'package:darkness_dungeon/map/TileMapConfig.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class TileMap{

  final String tileImg;
  final bool collision;
  Rect position;
  Sprite spriteTile;
  double size = TileMapConfig.size;

  TileMap(this.tileImg,{this.collision = false}) {
    position = Rect.fromLTWH(0,0, size, size);
    spriteTile = Sprite(tileImg);
  }

  void render(Canvas canvas) {
    spriteTile.renderRect(canvas, position);
  }
}