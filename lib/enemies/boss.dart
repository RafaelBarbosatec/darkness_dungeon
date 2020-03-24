import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Boss extends Enemy {
  final Position initPosition;
  double attack = 15;

  bool addChild = false;

  List<Enemy> childs = List();

  Boss({this.initPosition})
      : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/boss_idle.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/boss_idle.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/boss_run_right.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/boss_run_left.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          initPosition: initPosition,
          width: 32,
          height: 36,
          speed: 1,
          life: 200,
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    this.seePlayer(
      observed: (player) {
        if (childs.isEmpty || childs.where((e) => !e.isDead).length == 0) {
          addChildInMap();
        }
      },
      visionCells: 6,
    );

    this.seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      visionCells: 3,
    );
    super.update(dt);
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
        position: positionInWorld,
      ),
    );
    remove();
    super.die();
  }

  void addChildInMap() {
    if (this.timers['addChild'] == null) {
      this.timers['addChild'] = Timer(
        Duration(milliseconds: 6000),
        () {
          this.timers['addChild'] = null;
        },
      );
    } else {
      return;
    }

    Rect positionExplosion;

    switch (this.directionThatPlayerIs()) {
      case Direction.left:
        positionExplosion = positionInWorld.translate(width * -2, 0);
        break;
      case Direction.right:
        positionExplosion = positionInWorld.translate(width * 3, 0);
        break;
      case Direction.top:
        positionExplosion = positionInWorld.translate(0, height * -1);
        break;
      case Direction.bottom:
        positionExplosion = positionInWorld.translate(0, height * 2);
        break;
    }

    Enemy e = Imp(
      initPosition: Position(
        positionExplosion.left,
        positionExplosion.top,
      ),
    );

    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "enemy_explosin.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: positionExplosion,
      ),
    );

    childs.add(e);
    gameRef.addEnemy(e);
  }

  void execAttack() {
    this.simpleAttackMelee(
      heightArea: 20,
      widthArea: 20,
      damage: attack,
      interval: 1000,
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
