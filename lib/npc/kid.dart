import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/dialogs.dart';
import 'package:darkness_dungeon/util/functions.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/npc_sprite_sheet.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';

class Kid extends GameDecoration {
  bool conversationWithHero = false;

  final IntervalTick _timer = IntervalTick(1000);
  Kid(
    Vector2 position,
  ) : super.withAnimation(
          animation: NpcSpriteSheet.kidIdleLeft(),
          position: position,
          size: Vector2(valueByTileSize(8), valueByTileSize(11)),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (!conversationWithHero && _timer.update(dt)) {
      try {
        gameRef.enemies().firstWhere((e) => e is Boss);
      } catch (e) {
        conversationWithHero = true;
        gameRef.camera.moveToTargetAnimated(
          this,
          finish: () {
            _startConversation();
          },
        );
      }
    }
  }

  void _startConversation() {
    Sounds.interaction();
    TalkDialog.show(gameRef.context, [
      Say(
        text: [TextSpan(text: getString('talk_kid_2'))],
        person: CustomSpriteAnimationWidget(
          animation: NpcSpriteSheet.kidIdleLeft(),
        ),
        personSayDirection: PersonSayDirection.RIGHT,
      ),
      Say(
        text: [TextSpan(text: getString('talk_player_4'))],
        person: CustomSpriteAnimationWidget(
          animation: PlayerSpriteSheet.idleRight(),
        ),
        personSayDirection: PersonSayDirection.LEFT,
      ),
    ], onFinish: () {
      Sounds.interaction();
      gameRef.camera.moveToPlayerAnimated(finish: () {
        Dialogs.showCongratulations(gameRef.context);
      });
    }, onChangeTalk: (index) {
      Sounds.interaction();
    });
  }
}
