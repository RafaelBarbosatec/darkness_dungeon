import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class WizardNPC extends GameDecoration {
  bool _showConversation = false;
  WizardNPC(
    Position position,
  ) : super(
          animation: FlameAnimation.Animation.sequenced(
            "npc/wizard_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
          initPosition: position,
          width: 26,
          height: 32,
        );

  @override
  void update(double dt) {
    super.update(dt);
    this.seePlayer(
        observed: (player) {
          if (!_showConversation) {
            _showConversation = true;
            _showEmote(emote: 'emote/emote_interregacao.png');
            _showIntroduction();
          }
        },
        notObserved: () {
          _showConversation = false;
        },
        visionCells: 2);
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: FlameAnimation.Animation.sequenced(
          emote,
          8,
          textureWidth: 32,
          textureHeight: 32,
        ),
        target: this,
        width: 16,
        height: 16,
        positionFromTarget: Position(18, -6),
      ),
    );
  }

  void _showIntroduction() {
    showDialog(
      context: gameRef.context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.transparent,
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flame.util.animationAsWidget(
                    Position(80, 100),
                    FlameAnimation.Animation.sequenced(
                      "npc/wizard_idle_left.png",
                      4,
                      textureWidth: 16,
                      textureHeight: 22,
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
