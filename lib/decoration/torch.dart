import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:flutter/material.dart';

class Torch extends GameDecoration {
  bool empty = false;
  Torch(Vector2 position, {this.empty = false})
      : super.withAnimation(
          animation: GameSpriteSheet.torch(),
          position: position,
          size: Vector2.all(tileSize),
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

  @override
  void render(Canvas canvas) {
    if (!empty) {
      super.render(canvas);
    }
  }
}
