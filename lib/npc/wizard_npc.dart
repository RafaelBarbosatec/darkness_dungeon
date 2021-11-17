import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/npc_sprite_sheet.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';

class WizardNPC extends GameDecoration {
  bool _showConversation = false;
  WizardNPC(
    Vector2 position,
  ) : super.withAnimation(
          NpcSpriteSheet.wizardIdleLeft(),
          position: position,
          width: tileSize * 0.8,
          height: tileSize,
        );

  @override
  void update(double dt) {
    super.update(dt);
    this.seeComponentType<Player>(
      observed: (player) {
        if (!_showConversation) {
          _showConversation = true;
          _showEmote(emote: 'emote/emote_interregacao.png');
          _showIntroduction();
        }
      },
      radiusVision: (2 * tileSize),
    );
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: this,
        positionFromTarget: Rect.fromLTWH(
          18,
          -6,
          tileSize / 2,
          tileSize / 2,
        ).toVector2Rect(),
      ),
    );
  }

  void _showIntroduction() {
    Sounds.interaction();
    TalkDialog.show(gameRef.context, [
      Say(
        text: [
          TextSpan(text: getString('talk_wizard_1')),
        ],
        person: CustomSpriteAnimationWidget(
          animation: NpcSpriteSheet.wizardIdleLeft(),
        ),
        personSayDirection: PersonSayDirection.RIGHT,
      ),
      Say(
        text: [TextSpan(text: getString('talk_player_1'))],
        person: CustomSpriteAnimationWidget(
          animation: PlayerSpriteSheet.idleRight(),
        ),
        personSayDirection: PersonSayDirection.LEFT,
      ),
      Say(
        text: [TextSpan(text: getString('talk_wizard_2'))],
        person: CustomSpriteAnimationWidget(
          animation: NpcSpriteSheet.wizardIdleLeft(),
        ),
        personSayDirection: PersonSayDirection.RIGHT,
      ),
      Say(
        text: [TextSpan(text: getString('talk_player_2'))],
        person: CustomSpriteAnimationWidget(
          animation: PlayerSpriteSheet.idleRight(),
        ),
        personSayDirection: PersonSayDirection.LEFT,
      ),
      Say(
        text: [TextSpan(text: getString('talk_wizard_3'))],
        person: CustomSpriteAnimationWidget(
          animation: NpcSpriteSheet.wizardIdleLeft(),
        ),
        personSayDirection: PersonSayDirection.RIGHT,
      ),
    ], onChangeTalk: (index) {
      Sounds.interaction();
    }, onFinish: () {
      Sounds.interaction();
    });
  }
}
