import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:flutter/cupertino.dart';

class Door extends GameDecoration with ObjectCollision {
  bool open = false;
  bool showDialog = false;

  Door(Vector2 position, Size size)
      : super.withSprite(
          Sprite.load('itens/door_closed.png'),
          position: position,
          width: size.width,
          height: size.height,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Size(width, height / 4),
            align: Vector2(0, height * 0.75),
          ),
        ],
      ),
    );
  }

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
                animation: GameSpriteSheet.openTheDoor(),
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
      radiusVision: (1 * tileSize).toInt(),
    );
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          getString('door_without_key'),
          person: SpriteAnimationWidget(
            animation: (gameRef.player as SimplePlayer).animation.idleRight,
          ),
          personSayDirection: PersonSayDirection.LEFT,
        )
      ],
    );
  }
}
