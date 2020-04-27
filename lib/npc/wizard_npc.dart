import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/sounds.dart';
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
          width: tileSize * 0.8,
          height: tileSize,
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
    Sounds.interaction();
    TalkDialog.show(gameRef.context, [
      Say(
        getString('talk_wizard_1'),
        Flame.util.animationAsWidget(
          Position(80, 100),
          FlameAnimation.Animation.sequenced(
            "npc/wizard_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
        ),
        personDirection: PersonDirection.RIGHT,
      ),
      Say(
        getString('talk_player_1'),
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
      Say(
        getString('talk_wizard_2'),
        Flame.util.animationAsWidget(
          Position(80, 100),
          FlameAnimation.Animation.sequenced(
            "npc/wizard_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
        ),
        personDirection: PersonDirection.RIGHT,
      ),
      Say(
        getString('talk_player_2'),
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
      Say(
        getString('talk_wizard_3'),
        Flame.util.animationAsWidget(
          Position(80, 100),
          FlameAnimation.Animation.sequenced(
            "npc/wizard_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
        ),
        personDirection: PersonDirection.RIGHT,
      ),
    ], onChangeTalk: (index) {
      Sounds.interaction();
    }, finish: () {
      Sounds.interaction();
    });
  }
}
