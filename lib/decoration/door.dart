import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:flutter/cupertino.dart';

class Door extends GameDecoration {
  bool open = false;
  bool showDialog = false;

  Door(Vector2 position, Vector2 size)
      : super.withSprite(
          sprite: Sprite.load('items/door_closed.png'),
          position: position,
          size: size,
        );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: Vector2(width, height / 4),
      position: Vector2(0, height * 0.75),
    ));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Knight) {
      if (!open) {
        Knight p = other;
        if (p.containKey == true) {
          open = true;
          p.containKey = false;
          playSpriteAnimationOnce(
            GameSpriteSheet.openTheDoor(),
            onFinish: removeFromParent,
          );
        } else {
          if (!showDialog) {
            showDialog = true;
            _showIntroduction();
          }
        }
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [TextSpan(text: getString('door_without_key'))],
          person: (gameRef.player as SimplePlayer?)
                  ?.animation
                  ?.idleRight
                  ?.asWidget() ??
              SizedBox.shrink(),
          personSayDirection: PersonSayDirection.LEFT,
        )
      ],
      onClose: () {
        showDialog = false;
      },
    );
  }
}
