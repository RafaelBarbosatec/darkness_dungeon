import 'dart:async';

import 'package:darkness_dungeon/core/newCore/animated_object_once.dart';
import 'package:darkness_dungeon/core/newCore/enemy/new_enemy.dart';
import 'package:darkness_dungeon/core/newCore/player/new_player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Goblin2 extends NewEnemy {
  final Position initPosition;
  final double sizeTileMap;
  double attack = 10;
  Timer _timerAttack;
  bool _closePlayer;

  Goblin2({
    @required this.initPosition,
    this.sizeTileMap = 32,
  }) : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "goblin_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "goblin_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "goblin_run_right.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "goblin_run_right.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPosition: initPosition,
          sizeTileMap: sizeTileMap,
          width: 25,
          height: 25,
          speed: 1.5,
          life: 100,
        );

  @override
  void update(double dt) {
    _closePlayer = false;
    seeAndMoveToPlayer(
      visionCells: 5,
      closePlayer: (player) {
        _closePlayer = true;
        simpleAttackMelee(attack, player);
      },
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

  void simpleAttackMelee(double damage, NewPlayer player) {
    if (_timerAttack != null && _timerAttack.isActive) {
      return;
    }
    player.receiveDamage(damage);
    _timerAttack = Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      if (_closePlayer) {
        player.receiveDamage(damage);
      } else {
        _timerAttack.cancel();
      }
    });
  }
}
