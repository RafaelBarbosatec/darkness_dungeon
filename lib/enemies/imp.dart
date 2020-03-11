import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Imp extends Enemy {
  static double sizeTile = 32;
  final Position initPositionRelativeTile;
  double attack = 5;

  Imp({this.initPositionRelativeTile})
      : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/imp_idle.png",
            4,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/imp_idle.png",
            4,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/imp_run_right.png",
            4,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/imp_run_left.png",
            4,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPositionRelativeTile: initPositionRelativeTile,
          sizeTileMap: sizeTile,
          width: 25,
          height: 25,
          speed: 1.5,
          life: 100,
        );

  @override
  void update(double dt) {
    this.seeAndMoveToPlayer(
      visionCells: 5,
      closePlayer: (player) {
        execAttack();
      },
    );
    super.update(dt);
  }

  void execAttack() {
    this.simpleAttackMelee(
      heightArea: 20,
      widthArea: 20,
      damage: attack,
      interval: 300,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
    );
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "enemy_explosin.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: position,
      ),
    );
    remove();
    super.die();
  }
}
