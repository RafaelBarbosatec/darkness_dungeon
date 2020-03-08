import 'package:darkness_dungeon/core/player/player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Knight extends Player {
  final double width;
  final double height;
  final Position initPosition;
  double attack = 20;

  Knight({
    this.width,
    this.height,
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
          width: width,
          height: height,
          sizeTileMap: 32,
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
    this.simpleAttackRange(
      animationRight: FlameAnimation.Animation.sequenced(
        'player/fireball_right.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationLeft: FlameAnimation.Animation.sequenced(
        'player/fireball_left.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationDestroy: FlameAnimation.Animation.sequenced(
        'enemy_explosin.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      width: 25,
      height: 25,
      damage: 10,
      speed: 2,
    );
    return;
    simpleAttackMelee(
      attack,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
    );
  }
}
