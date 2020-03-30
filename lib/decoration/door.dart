import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/conversation.dart';
import 'package:darkness_dungeon/util/talk.dart';
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
          } else {
            _showIntroduction();
          }
        }
      },
      visionCells: 1,
    );
  }

  void _showIntroduction() {
    Conversation.show(
      gameRef.context,
      [
        Talk(
          'Acho que preciso de uma chave para passar por aqui!',
          Flame.util.animationAsWidget(
            Position(80, 100),
            FlameAnimation.Animation.sequenced(
              "player/knight_idle.png",
              4,
              textureWidth: 16,
              textureHeight: 22,
            ),
          ),
          personDirection: PersonDirection.LEFT,
        )
      ],
    );
  }
}
