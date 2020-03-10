import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Imp extends Enemy {
  static double sizeTile = 32;
  final Position initPosition;
  double attack = 5;

  Imp({this.initPosition})
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
          initPosition: initPosition,
          sizeTileMap: sizeTile,
          width: 25,
          height: 25,
          speed: 1.5,
          life: 100,
        );

  @override
  void update(double dt) {
    this.seeAndMoveToAttackRange(positioned: (p) {
      execAttackRange();
    });
    super.update(dt);
  }

  void execAttackRange() {
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
      animationTop: FlameAnimation.Animation.sequenced(
        'player/fireball_top.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationBottom: FlameAnimation.Animation.sequenced(
        'player/fireball_bottom.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationDestroy: FlameAnimation.Animation.sequenced(
        'player/explosion_fire.png',
        6,
        textureWidth: 32,
        textureHeight: 32,
      ),
      width: 25,
      height: 25,
      damage: 10,
      speed: speed * 1.5,
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
