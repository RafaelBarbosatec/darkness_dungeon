import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:flutter/material.dart';

class Torch extends GameDecoration with Lighting {
  Torch(Vector2 position, {bool empty = false})
      : super.withAnimation(
          empty ? null : GameSpriteSheet.torch(),
          position: position,
          width: tileSize,
          height: tileSize,
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 2.5,
        blurBorder: width,
        pulseVariation: 0.1,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }
}
