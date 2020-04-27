import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/interface/bar_life_component.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  Sprite key;
  KnightInterface() {
    key = Sprite('itens/key_silver.png');
  }

  @override
  void resize(Size size) {
    add(BarLifeComponent());
    super.resize(size);
  }

  @override
  void render(Canvas c) {
    try {
      _drawKey(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Knight).containKey) {
      key.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
