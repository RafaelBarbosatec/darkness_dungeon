
import 'package:darkness_dungeon/decoration/Decoration.dart';
import 'package:darkness_dungeon/enemy/Enemy.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class TileMap{

  static const double SIZE = 16;

  final String tileImg;
  final bool collision;
  final Enemy enemy;
  final TileDecoration decoration;
  Rect position;
  Sprite spriteTile;
  final double size = TileMap.SIZE;

  TileMap(this.tileImg,{this.collision = false,this.enemy,this.decoration}) {
    position = Rect.fromLTWH(0,0, size, size);
    spriteTile = Sprite(tileImg.isEmpty? "tile/empty.png": tileImg);
  }

  void render(Canvas canvas) {
    spriteTile.renderRect(canvas, position);
  }

  @override
  String toString() {
    return 'TileMap{tileImg: $tileImg, collision: $collision, position: $position, spriteTile: $spriteTile, size: $size}';
  }


}