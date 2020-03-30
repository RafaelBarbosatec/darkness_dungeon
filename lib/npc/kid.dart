import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/util/conversation.dart';
import 'package:darkness_dungeon/util/talk.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Kid extends GameDecoration {
  bool conversationWithHero = false;
  Kid(
    Position position,
  ) : super(
          animation: FlameAnimation.Animation.sequenced(
            "npc/kid_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
          initPosition: position,
          width: 20,
          height: 26,
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (!conversationWithHero) {
      Boss boss = gameRef.enemies.firstWhere((e) => e is Boss);
      if (boss != null && boss.isDead) {
        conversationWithHero = true;
        gameRef.gameCamera.moveToPositionAnimated(
          Position(
            positionInWorld.left,
            positionInWorld.top,
          ),
          finish: () {
            _startConversation();
          },
        );
      }
    }
  }

  void _startConversation() {
    Conversation.show(
        gameRef.context,
        [
          Talk(
            'Graças a deus!!!\nVocê conseguiu derrotar essa criatura horrível! Muito Obrigado!\nNem sei como te agradecer!',
            Flame.util.animationAsWidget(
              Position(80, 100),
              FlameAnimation.Animation.sequenced(
                "npc/kid_idle_left.png",
                4,
                textureWidth: 16,
                textureHeight: 22,
              ),
            ),
            personDirection: PersonDirection.RIGHT,
          ),
          Talk(
            'Foi uma horra poder te ajudar! E não se preocupe em me recompensar, seu pai me prometeu uma fortuna para te resgatar! :-)',
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
          ),
        ],
        finish: () {});
  }
}
