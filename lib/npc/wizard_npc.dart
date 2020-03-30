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
    Conversation.show(
      gameRef.context,
      [
        Talk(
          'Olá meu jovem cavaleiro!\nOque você faz aqui?',
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
        Talk(
          'Olá!\nFui enviado para resgatar uma criança que foi sequestradas por criaturas que moram nessas redondezas.',
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
        Talk(
          'Humm...\nNão quero te desmotivar, mas você é o quinto cavaleiro enviado para essa tarefa. Até o momento nenhum retornou com vida e seus corpos estão pindurados pelas paredes como trofeus.',
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
        Talk(
          'Não se preocupe meu velhinho. Caveleiro igual a mim jamais existiu!\nVou exterminar cada criatura desse lugar e resgatar a criança!',
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
        Talk(
          'É, alto estima é oque não falta em você!\nDepois não diga que não avisei!\nBoa sorte!',
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
      ],
    );
  }
}
