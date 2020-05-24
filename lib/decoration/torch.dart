import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class Torch extends GameDecoration with WithLighting {
  Torch(Position position, {bool empty = false})
      : super.animation(
          empty
              ? null
              : FlameAnimation.Animation.sequenced(
                  "itens/torch_spritesheet.png",
                  6,
                  textureWidth: 16,
                  textureHeight: 16,
                ),
          initPosition: position,
          width: tileSize,
          height: tileSize,
        ) {
    lightingConfig = LightingConfig(
      gameComponent: this,
      color: Colors.yellow.withOpacity(0.1),
      radius: width * 2.5,
      blurBorder: width / 2,
      withPulse: true,
      pulseVariation: 0.1,
    );
  }
}
