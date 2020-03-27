import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Door extends GameDecoration {
  bool open = false;

  Door(Position position)
      : super(
          spriteImg: 'itens/door_closed.png',
          initPosition: position,
          width: 64,
          height: 64,
          collision: true,
        );

  @override
  void update(double dt) {
    super.update(dt);
    this.seePlayer(
      observed: (player) {
        if (!open) {
          if ((player as Knight).containKey) {
            open = true;
            gameRef.add(
              AnimatedObjectOnce(
                animation: FlameAnimation.Animation.sequenced(
                  'itens/door_open.png',
                  14,
                  textureWidth: 32,
                  textureHeight: 32,
                ),
                position: positionInWorld,
                onFinish: () {
                  (player as Knight).containKey = false;
                },
              ),
            );
            Future.delayed(Duration(milliseconds: 200), () {
              remove();
            });
          }
        }
      },
      visionCells: 1,
    );
  }
}
