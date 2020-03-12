import 'package:darkness_dungeon/core/decoration/decoration.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:darkness_dungeon/decoration/potion_life.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Chest extends GameDecoration {
  final Position initPosition;
  Chest(this.initPosition)
      : super(
          animation: FlameAnimation.Animation.sequenced(
            "itens/chest_spritesheet.png",
            8,
            textureWidth: 16,
            textureHeight: 16,
          ),
          width: 16,
          height: 16,
          initPosition: initPosition,
        );

  @override
  void update(double dt) {
    this.seePlayer(
        observed: (player) {
          gameRef.addDecoration(PotionLife(Position(
            positionInWorld.translate(width * 2, 0).left,
            positionInWorld.top,
          )));

          gameRef.addDecoration(PotionLife(Position(
            positionInWorld.translate(width * 2, 0).left,
            positionInWorld.top + height * 2,
          )));

          gameRef.add(
            AnimatedObjectOnce(
              animation: FlameAnimation.Animation.sequenced(
                "enemy_explosin.png",
                6,
                textureWidth: 16,
                textureHeight: 16,
              ),
              position: position.translate(width * 2, 0),
            ),
          );

          gameRef.add(
            AnimatedObjectOnce(
              animation: FlameAnimation.Animation.sequenced(
                "enemy_explosin.png",
                6,
                textureWidth: 16,
                textureHeight: 16,
              ),
              position: position.translate(width * 2, height * 2),
            ),
          );

          remove();
        },
        visionCells: 1);
    super.update(dt);
  }
}
