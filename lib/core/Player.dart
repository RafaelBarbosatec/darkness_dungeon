import 'dart:async';
import 'dart:math';

import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:darkness_dungeon/core/Decoration.dart';
import 'package:darkness_dungeon/core/Direction.dart';
import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/ObjectCollision.dart';
import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

import 'Direction.dart';

class Player extends AnimationGameObject with ObjectCollision {
  double life;
  MapControll _mapControl;
  double stamina = 100;
  double costStamina = 15;
  final double size;
  final double damageAttack;
  final Size screenSize;
  final double speedPlayer;
  final Function(double) changeLife;
  final Function(double) changeStamina;
  final Function callBackDie;
  final FlameAnimation.Animation animationIdle;
  final FlameAnimation.Animation animationIdleLeft;
  final FlameAnimation.Animation animationMoveLeft;
  final FlameAnimation.Animation animationMoveRight;
  final FlameAnimation.Animation animationMoveTop;
  final FlameAnimation.Animation animationMoveBottom;
  final FlameAnimation.Animation animationDie;
  final FlameAnimation.Animation animationAttackLeft;
  final FlameAnimation.Animation animationAttackRight;
  final FlameAnimation.Animation animationAttackTop;
  final FlameAnimation.Animation animationAttackBottom;
  AnimationGameObject attackObject = AnimationGameObject();
  Direction lasDirection = Direction.right;
  Direction lasDirectionHorizontal = Direction.right;
  Timer _timerStamina;
  bool notifyDie = false;
  bool isIdle = true;
  Rect initPosition;
  List<Enemy> _enemies = List();

  Player(
    this.size,
    this.screenSize,
    Rect position,
    this.animationIdle, {
    this.damageAttack = 1,
    this.life = 1,
    this.speedPlayer = 1,
    this.animationIdleLeft,
    this.animationMoveLeft,
    this.animationMoveRight,
    this.animationMoveTop,
    this.animationMoveBottom,
    this.animationDie,
    this.animationAttackLeft,
    this.animationAttackRight,
    this.animationAttackTop,
    this.animationAttackBottom,
    this.changeLife,
    this.changeStamina,
    this.callBackDie,
  }) {
    initPosition = position;
    this.position = position;
    animation = animationIdle;
    widthCollision = position.width;
    heightCollision = position.height / 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (life > 0) {
      attackObject.render(canvas);
    }
  }

  void setMapControl(MapControll mapControl) {
    _mapControl = mapControl;
  }

  void updatePlayer(double dt, List<Rect> collisionsMap, List<Enemy> enemies,
      List<TileDecoration> decorations) {
    super.update(dt);
    this.collisionsMap = collisionsMap;
    this._enemies = enemies;
    _updateAttackObject(dt);
  }

  void moveToTop() {
    if (life == 0) {
      return;
    }

    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate(0, (speedPlayer * -1));
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.top > screenSize.height / 2.9 || _mapControl.isMaxTop()) {
      position = displacement;
    } else {
      _mapControl.moveTop(speedPlayer);
    }

    if (animationMoveTop != null && lasDirection != Direction.top || isIdle) {
      isIdle = false;
      lasDirection = Direction.top;
      animation = animationMoveTop;
      attackObject.animation = null;
    }
  }

  void moveToBottom() {
    if (life == 0) {
      return;
    }

    if (position.bottom >= screenSize.height) {
      return;
    }

    Rect displacement = position.translate(0, speedPlayer);
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.top < screenSize.height / 1.9 || _mapControl.isMaxBottom()) {
      position = displacement;
    } else {
      _mapControl.moveBottom(speedPlayer);
    }

    if (animationMoveBottom != null && lasDirection != Direction.bottom ||
        isIdle) {
      isIdle = false;
      lasDirection = Direction.bottom;
      animation = animationMoveBottom;
      attackObject.animation = null;
    }
  }

  void moveToLeft() {
    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }

    Rect displacement = position.translate((speedPlayer * -1), 0);
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.left > screenSize.width / 3 || _mapControl.isMaxLeft()) {
      position = displacement;
    } else {
      _mapControl.moveLeft(speedPlayer);
    }

    lasDirectionHorizontal = Direction.left;

    if (animationMoveLeft != null && lasDirection != Direction.left || isIdle) {
      isIdle = false;
      lasDirection = Direction.left;
      animation = animationMoveLeft;
      attackObject.animation = null;
    }
  }

  void moveToRight() {
    if (life == 0) {
      return;
    }

    if (position.right >= screenSize.width) {
      return;
    }

    Rect displacement = position.translate(speedPlayer, 0);
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.left < screenSize.width / 1.5 || _mapControl.isMaxRight()) {
      position = displacement;
    } else {
      _mapControl.moveRight(speedPlayer);
    }

    lasDirectionHorizontal = Direction.right;

    if (animationMoveRight != null && lasDirection != Direction.right ||
        isIdle) {
      isIdle = false;
      lasDirection = Direction.right;
      animation = animationMoveRight;
      attackObject.animation = null;
    }
  }

  void runTopRight() {
    if (life == 0) {
      return;
    }

    if (position.left >= screenSize.width) {
      return;
    }

    if (position.top <= 0) {
      return;
    }

    Rect displacementRight = position.translate(speedPlayer, 0);

    if (!verifyCollisionRect(displacementRight)) {
      if (position.left < screenSize.width / 1.5 || _mapControl.isMaxRight()) {
        position = displacementRight;
      } else {
        _mapControl.moveRight(speedPlayer);
      }

      if (animationMoveRight != null) {
        animation = animationMoveRight;
      }
    }

    Rect displacementTop = position.translate(0, (-1 * speedPlayer));

    if (!verifyCollisionRect(displacementTop)) {
      if (position.top > screenSize.height / 3 || _mapControl.isMaxTop()) {
        position = displacementTop;
      } else {
        _mapControl.moveTop(speedPlayer);
      }

      if (animationMoveRight != null) {
        animation = animationMoveRight;
      }
    }
  }

  void runTopLeft() {
    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }

    if (position.top <= 0) {
      return;
    }

    Rect displacementLeft = position.translate((-1 * speedPlayer), 0);

    if (!verifyCollisionRect(displacementLeft)) {
      if (position.left > screenSize.width / 1.5 || _mapControl.isMaxLeft()) {
        position = displacementLeft;
      } else {
        _mapControl.moveLeft(speedPlayer);
      }
      if (animationMoveLeft != null) {
        animation = animationMoveLeft;
      }
    }

    Rect displacementTop = position.translate(0, (-1 * speedPlayer));

    if (!verifyCollisionRect(displacementTop)) {
      if (position.top > screenSize.height / 3 || _mapControl.isMaxTop()) {
        position = displacementTop;
      } else {
        _mapControl.moveTop(speedPlayer);
      }

      if (animationMoveLeft != null) {
        animation = animationMoveLeft;
      }
    }
  }

  void runBottomLeft() {
    //print('runBottomLeft');
    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }

    if (position.bottom >= screenSize.height) {
      return;
    }

    Rect displacementLeft = position.translate((-1 * speedPlayer), 0);

    if (!verifyCollisionRect(displacementLeft)) {
      if (position.left > screenSize.width / 1.5 || _mapControl.isMaxLeft()) {
        position = displacementLeft;
      } else {
        _mapControl.moveLeft(speedPlayer);
      }

      if (animationMoveLeft != null) {
        animation = animationMoveLeft;
      }
    }

    Rect displacementBottom = position.translate(0, speedPlayer);

    if (!verifyCollisionRect(displacementBottom)) {
      if (position.top < screenSize.height / 1.5 || _mapControl.isMaxBottom()) {
        position = displacementBottom;
      } else {
        _mapControl.moveBottom(speedPlayer);
      }

      if (animationMoveLeft != null) {
        animation = animationMoveLeft;
      }
    }
  }

  void runBottomRight() {
    if (life == 0) {
      return;
    }

    if (position.left >= screenSize.width) {
      return;
    }

    if (position.top >= screenSize.height) {
      return;
    }

    Rect displacementRight = position.translate(speedPlayer, 0);

    if (!verifyCollisionRect(displacementRight)) {
      if (position.left < screenSize.width / 1.5 || _mapControl.isMaxRight()) {
        position = displacementRight;
      } else {
        _mapControl.moveRight(speedPlayer);
      }

      if (animationMoveRight != null) {
        animation = animationMoveRight;
      }
    }

    Rect displacementBottom = position.translate(0, speedPlayer);

    if (!verifyCollisionRect(displacementBottom)) {
      if (position.top < screenSize.height / 1.5 || _mapControl.isMaxBottom()) {
        position = displacementBottom;
      } else {
        _mapControl.moveBottom(speedPlayer);
      }

      if (animationMoveRight != null) {
        animation = animationMoveRight;
      }
    }
  }

  void idle() {
    if (life == 0) {
      return;
    }

    if (lasDirectionHorizontal == Direction.right) {
      animation = animationIdle;
    } else {
      animation = animationIdleLeft;
    }

    isIdle = true;
  }

  void receiveAttack(double damage) {
    life = life - damage;
    if (changeLife != null) {
      changeLife(life);
    }
    if (life < 0) {
      life = 0;
    }
    if (life == 0) {
      die();
    }
  }

  void die() {
    if (callBackDie != null && !notifyDie) {
      notifyDie = true;
      callBackDie();
    }
    animation = FlameAnimation.Animation.sequenced("crypt.png", 1,
        textureWidth: 16, textureHeight: 16);
  }

  void attack() {
    if (life <= 0) {
      return;
    }

    startTimeStamina();

    if (stamina < costStamina) {
      return;
    }

    stamina = stamina - costStamina;

    if (changeStamina != null) {
      changeStamina(stamina);
    }

    switch (lasDirection) {
      case Direction.top:
        attackObject.animation = animationAttackTop;
        break;
      case Direction.bottom:
        attackObject.animation = animationAttackBottom;
        break;
      case Direction.left:
        attackObject.animation = animationAttackLeft;
        break;
      case Direction.right:
        attackObject.animation = animationAttackRight;
        break;
    }

    attackObject.animation.clock = 0;
    attackObject.animation.currentIndex = 0;
    attackObject.animation.loop = true;

    double damageMin = damageAttack / 2;
    int p = Random().nextInt(damageAttack.toInt() + (damageMin.toInt()));
    double damage = damageMin + p;

    List<Enemy> enemyLife = _enemies.where((e) => !e.isDie()).toList();
    enemyLife.forEach((enemy) {
      if (attackObject.position.overlaps(enemy.getCurrentPosition())) {
        enemy.receiveDamage(damage, lasDirection);
      }
    });
  }

  void startTimeStamina() {
    if (_timerStamina != null && _timerStamina.isActive) {
      return;
    }
    _timerStamina = Timer.periodic(new Duration(milliseconds: 150), (timer) {
      if (life == 0) {
        return;
      }

      stamina = stamina + 1.5;
      if (stamina > 100) {
        stamina = 100;
      }
      changeStamina(stamina);
    });
  }

  void reset(double x, double y) {
    notifyDie = false;
    this.animation = animationIdle;
    this.position = initPosition;
    stamina = 100;
    life = 100;
  }

  void _updateAttackObject(double dt) {
    double top = position.top;
    double left = position.left;
    switch (lasDirection) {
      case Direction.top:
        top = top - size;
        break;
      case Direction.bottom:
        top = top + size;
        break;
      case Direction.left:
        left = left - size;
        break;
      case Direction.right:
        left = left + size;
        break;
    }

    if (position != null) {
      attackObject.position = Rect.fromLTWH(left, top, size, size);
    }

    attackObject.update(dt);

    if (attackObject.animation != null) {
      if (attackObject.animation.isLastFrame) {
        attackObject.animation.loop = false;
      }
    }
  }
}
