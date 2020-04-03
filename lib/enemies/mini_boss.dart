import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MiniBoss extends Enemy {
  final Position initPosition;
  double attack = 50;
  bool _seePlayerClose = false;

  MiniBoss({
    @required this.initPosition,
  }) : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_idle.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_run_right.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_run_left.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          initPosition: initPosition,
          width: 22,
          height: 30,
          speed: 1.5,
          life: 150,
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _seePlayerClose = false;
    this.seePlayer(
      observed: (player) {
        _seePlayerClose = true;
        this.seeAndMoveToPlayer(
          closePlayer: (player) {
            execAttack();
          },
          visionCells: 3,
        );
      },
      visionCells: 3,
    );
    if (!_seePlayerClose) {
      this.seeAndMoveToAttackRange(
        positioned: (p) {
          execAttackRange();
        },
        visionCells: 7,
      );
    }
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "smoke_explosin.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: positionInWorld,
      ),
    );
    remove();
    super.die();
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
      damage: attack,
      speed: speed * 1.5,
      execute: () {
        Sounds.attackRange();
      },
      destroy: () {
        Sounds.explosion();
      },
    );
  }

  void execAttack() {
    this.simpleAttackMelee(
        heightArea: 20,
        widthArea: 20,
        damage: attack / 3,
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
        execute: () {
          Sounds.attackEnemyMelee();
        });
  }

  @override
  void receiveDamage(double damage) {
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage);
  }
}
