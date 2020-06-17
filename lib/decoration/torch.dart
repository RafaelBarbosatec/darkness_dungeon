import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:flame/animation.dart' as FlameAnimation;

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
      radius: width * 2.5,
      blurBorder: width,
      withPulse: true,
      pulseVariation: 0.1,
    );
  }
}
