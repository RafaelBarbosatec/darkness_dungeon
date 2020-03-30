import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/util/conversation.dart';
import 'package:darkness_dungeon/util/talk.dart';
import 'package:flame/animation.dart' as FlameAnimation;

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
    Conversation.show(gameRef.context, [
      Talk(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis pulvinar libero, sit amet finibus lectus porttitor at. ',
          Flame.util.animationAsWidget(
            Position(80, 100),
            FlameAnimation.Animation.sequenced(
              "npc/wizard_idle_left.png",
              4,
              textureWidth: 16,
              textureHeight: 22,
            ),
          ),
          personDirection: PersonDirection.RIGHT),
      Talk(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis pulvinar libero, sit amet finibus lectus porttitor at. ',
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
    ], finish: () {
      print('finish');
    }, onChangeTalk: (index) {
      print(index);
    });
  }
}
