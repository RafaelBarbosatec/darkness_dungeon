import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Goblin extends Enemy {
  final Position initPosition;
  double attack = 25;

  Goblin({
    @required this.initPosition,
  }) : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/goblin/goblin_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/goblin/goblin_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/goblin/goblin_run_right.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/goblin/goblin_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPosition: initPosition,
          width: 25,
          height: 25,
          speed: 1.5,
          life: 120,
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    this.seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      visionCells: 4,
    );
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

  void execAttack() {
    this.simpleAttackMelee(
        heightArea: 20,
        widthArea: 20,
        damage: attack,
        interval: 800,
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
          Flame.audio.play('attack_enemy.mp3');
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
