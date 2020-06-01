import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/util/dialogs.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/sounds.dart';
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
      Boss boss = gameRef.livingEnemies().firstWhere((e) => e is Boss);
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
    Sounds.interaction();
    TalkDialog.show(gameRef.context, [
      Say(
        getString('talk_kid_2'),
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
      Say(
        getString('talk_player_4'),
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
    ], finish: () {
      Sounds.interaction();
      gameRef.gameCamera.moveToPlayerAnimated(finish: () {
        Dialogs.showCongratulations(gameRef.context);
      });
    }, onChangeTalk: (index) {
      Sounds.interaction();
    });
  }
}
