
import 'package:darkness_dungeon/Enemy.dart';
import 'package:darkness_dungeon/map/TileMapConfig.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class TileMap{

  final String tileImg;
  final bool collision;
  final Enemy enemy;
  Rect position;
  Sprite spriteTile;
  double size = TileMapConfig.size;

  TileMap(this.tileImg,{this.collision = false,this.enemy}) {
    position = Rect.fromLTWH(0,0, size, size);
    spriteTile = Sprite(tileImg);
  }

  void render(Canvas canvas) {
    spriteTile.renderRect(canvas, position);
  }

  @override
  String toString() {
    return 'TileMap{tileImg: $tileImg, collision: $collision, position: $position, spriteTile: $spriteTile, size: $size}';
  }


}