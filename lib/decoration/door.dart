import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/cupertino.dart';

class Door extends GameDecoration {
  bool open = false;
  bool showDialog = false;

  Door(Position position, double width, double height)
      : super.sprite(
          Sprite('itens/door_closed.png'),
          initPosition: position,
          width: width,
          height: height,
          frontFromPlayer: true,
          collision: Collision(
            width: width,
            height: height / 4,
            align: Offset(0, height * 0.75),
          ),
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
                position: this.position,
                onFinish: () {
                  (player as Knight).containKey = false;
                },
              ),
            );
            Future.delayed(Duration(milliseconds: 200), () {
              remove();
            });
          } else {
            if (!showDialog) {
              showDialog = true;
              _showIntroduction();
            }
          }
        }
      },
      notObserved: () {
        showDialog = false;
      },
      visionCells: 1,
    );
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          getString('door_without_key'),
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
