import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/interface/bar_life_component.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  late Sprite key;

  @override
  Future<void> onLoad() async {
    key = await Sprite.load('itens/key_silver.png');
    add(BarLifeComponent());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawKey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Knight).containKey) {
      key.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
