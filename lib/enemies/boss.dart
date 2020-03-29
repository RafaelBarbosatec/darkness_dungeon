import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:darkness_dungeon/enemies/mini_boss.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Boss extends Enemy {
  final Position initPosition;
  double attack = 40;

  bool addChild = false;

  List<Enemy> childs = List();

  Boss({this.initPosition})
      : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/boss/boss_idle.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/boss/boss_idle.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/boss/boss_run_right.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/boss/boss_run_left.png",
            4,
            textureWidth: 32,
            textureHeight: 36,
          ),
          initPosition: initPosition,
          width: 36,
          height: 40,
          speed: 1,
          life: 200,
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    drawBarInvoquerEnemy(canvas);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.seePlayer(
      observed: (player) {
        if (childs.isEmpty ||
            childs.where((e) => !e.isDead).length == 0 && childs.length < 3) {
          addChildInMap();
        }
      },
      visionCells: 4,
    );

    this.seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      visionCells: 3,
    );
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "explosion.png",
          7,
          textureWidth: 32,
          textureHeight: 32,
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
        positionExplosion = positionInWorld.translate(width * 2, 0);
        break;
      case Direction.top:
        positionExplosion = positionInWorld.translate(0, height * -2);
        break;
      case Direction.bottom:
        positionExplosion = positionInWorld.translate(0, height * 2);
        break;
    }

    Enemy e = childs.length == 2
        ? MiniBoss(
            initPosition: Position(
              positionExplosion.left,
              positionExplosion.top,
            ),
          )
        : Imp(
            initPosition: Position(
              positionExplosion.left,
              positionExplosion.top,
            ),
          );

    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "smoke_explosin.png",
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
      interval: 1500,
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

  void drawBarInvoquerEnemy(Canvas canvas) {
    double yPosition = position.top;
    double widthBar = (width - 10) / 3;
    if (childs.length < 1)
      canvas.drawLine(
          Offset(position.left, yPosition),
          Offset(position.left + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    double lastX = position.left + widthBar + 5;
    if (childs.length < 2)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    lastX = lastX + widthBar + 5;
    if (childs.length < 3)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
  }
}
