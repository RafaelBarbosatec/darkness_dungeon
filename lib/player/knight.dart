import 'package:darkness_dungeon/core/player/player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Knight extends Player {
  final double size;
  final Position initPosition;
  double attack = 20;

  Knight({
    this.size,
    this.initPosition,
  }) : super(
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleRight: FlameAnimation.Animation.sequenced(
            "knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          size: size,
          initPosition: initPosition,
        ) {
    speed = 3;
    life = 200;
  }

  @override
  void joystickAction(int action) {
    super.joystickAction(action);
    if (action == 0) {
      actionAttack();
    }
  }

  @override
  void die() {
    remove();
    super.die();
  }

  void actionAttack() {
    simpleAttackMelee(
      attack,
      attackBottomAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackLeftAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackRightAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackTopAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
    );
  }
}
