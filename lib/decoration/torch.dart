import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Torch extends GameDecoration {
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
        );
}
