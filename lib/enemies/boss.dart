import 'dart:async';

import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/util/Direction.dart';
import 'package:darkness_dungeon/core/util/animated_object_once.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/widgets.dart';

class Boss extends Enemy {
  static double sizeTile = 32;
  final Position initPositionRelativeTile;
  double attack = 10;

  bool addChild = false;

  List<Enemy> childs = List();

  Boss({this.initPositionRelativeTile})
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
          initPositionRelativeTile: initPositionRelativeTile,
          sizeTileMap: sizeTile,
          width: 32,
          height: 36,
          speed: 1.5,
          life: 100,
        );

  @override
  void update(double dt) {
    this.seePlayer(
      observed: (player) {
        if (childs.isEmpty || childs.where((e) => !e.isDie).length == 0) {
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
        position: position,
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

    Position positionChild;
    Rect positionExplosion;

    switch (this.directionThatPlayerIs()) {
      case Direction.left:
        positionChild = Position((positionInWorld.left - width * 2) / sizeTile,
            positionInWorld.top / sizeTile);
        positionExplosion = position.translate(width * -2, 0);
        break;
      case Direction.right:
        positionChild = Position((positionInWorld.right + width * 2) / sizeTile,
            positionInWorld.top / sizeTile);
        positionExplosion = position.translate(width * 3, 0);
        break;
      case Direction.top:
        positionChild = Position(positionInWorld.left / sizeTile,
            (positionInWorld.top - height) / sizeTile);
        positionExplosion = position.translate(0, height * -1);
        break;
      case Direction.bottom:
        positionChild = Position(positionInWorld.left / sizeTile,
            (positionInWorld.bottom + height) / sizeTile);
        positionExplosion = position.translate(0, height * 2);
        break;
    }

    Enemy e = Imp(
      initPositionRelativeTile: positionChild,
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
      interval: 500,
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
}
