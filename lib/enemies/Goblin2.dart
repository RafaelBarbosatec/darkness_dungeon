import 'dart:async';

import 'package:darkness_dungeon/core/newCore/animated_object_once.dart';
import 'package:darkness_dungeon/core/newCore/new_enemy.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Goblin2 extends NewEnemy {
  final Position initPosition;
  final double sizeTileMap;

  Timer _timerAttack;
  bool closePlayer = false;
  double attack = 10;

  Goblin2({
    @required this.initPosition,
    this.sizeTileMap = 32,
  }) : super(
            animationIdle: FlameAnimation.Animation.sequenced(
              "goblin_idle.png",
              6,
              textureWidth: 16,
              textureHeight: 16,
            ),
            initPosition: initPosition,
            sizeTileMap: sizeTileMap,
            width: 25,
            height: 25,
            speed: 1.5,
            life: 100);

  @override
  void update(double dt) {
    closePlayer = false;
    seeAndMoveToPlayer(
      visionCells: 5,
      closePlayer: _attack,
    );

    if (!destroy() && life == 0) {
      remove();
      gameRef.add(AnimatedObjectOnce(
          animation: FlameAnimation.Animation.sequenced(
            "enemy_explosin.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          position: position));
    }
    super.update(dt);
  }

  void _attack(NewPlayer player) {
    closePlayer = true;
    if (_timerAttack != null && _timerAttack.isActive) {
      return;
    }
    player.life -= attack;
    _timerAttack = Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      if (closePlayer) {
        player.life -= attack;
        print(player.life);
      } else {
        _timerAttack.cancel();
        print(closePlayer);
      }
    });
  }
}
