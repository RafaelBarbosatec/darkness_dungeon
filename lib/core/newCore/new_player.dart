import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/animated_object_once.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/new_object_collision.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

import 'joystick_controller.dart';

class NewPlayer extends AnimatedObject
    with HasGameRef<RPGGame>, NewObjectCollision
    implements JoystickListener {
  static const REDUCTION_SPEED_DIAGONAL = 0.7;

  final double size;
  final Position initPosition;
  final Directional initDirectional;
  final FlameAnimation.Animation animIdleLeft;
  final FlameAnimation.Animation animIdleRight;
  final FlameAnimation.Animation animIdleTop;
  final FlameAnimation.Animation animIdleBottom;
  final FlameAnimation.Animation animRunTop;
  final FlameAnimation.Animation animRunRight;
  final FlameAnimation.Animation animRunBottom;
  final FlameAnimation.Animation animRunLeft;
  double speed;
  double life;
  Directional statusDirectional;
  Directional lastDirectional;
  Directional _statusHorizontalDirectional = Directional.MOVE_RIGHT;
  bool _isDie = false;

  NewPlayer({
    @required this.animIdleLeft,
    @required this.animIdleRight,
    this.animIdleTop,
    this.animIdleBottom,
    this.animRunTop,
    @required this.animRunRight,
    this.animRunBottom,
    @required this.animRunLeft,
    this.size = 0,
    this.initPosition,
    this.initDirectional = Directional.MOVE_RIGHT,
    this.speed = 5,
    this.life = 10,
  }) {
    statusDirectional = initDirectional;
    lastDirectional = initDirectional;

    if (initDirectional == Directional.MOVE_LEFT ||
        initDirectional == Directional.MOVE_RIGHT) {
      _statusHorizontalDirectional = initDirectional;
    }

    position = Rect.fromLTWH(
      (initPosition != null ? initPosition.x : 0.0) * size,
      (initPosition != null ? initPosition.y : 0.0) * size,
      size,
      size,
    );

    widthCollision = size;
    heightCollision = size / 3;

    _idle();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void joystickAction(int action) {
    if (_isDie) return;
    print(action);
  }

  @override
  void joystickChangeDirectional(Directional directional) {
    if (_isDie) return;
    switch (directional) {
      case Directional.MOVE_TOP:
        _moveTop();
        break;
      case Directional.MOVE_TOP_LEFT:
        _moveTopLeft();
        break;
      case Directional.MOVE_TOP_RIGHT:
        _moveTopRight();
        break;
      case Directional.MOVE_RIGHT:
        _moveRight();
        break;
      case Directional.MOVE_BOTTOM:
        _moveBottom();
        break;
      case Directional.MOVE_BOTTOM_RIGHT:
        _moveBottomRight();
        break;
      case Directional.MOVE_BOTTOM_LEFT:
        _moveBottomLeft();
        break;
      case Directional.MOVE_LEFT:
        _moveLeft();
        break;
      case Directional.IDLE:
        _idle();
        break;
    }
  }

  void _moveTop({bool addAnimation = true, bool isDiagonal = false}) {
    double speed =
        isDiagonal ? this.speed * REDUCTION_SPEED_DIAGONAL : this.speed;
    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate(0, (speed * -1));

    if (isCollision(displacement, gameRef)) {
      return;
    }

    if (position.top > gameRef.size.height / 2.9 || gameRef.map.isMaxTop()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_TOP);
    }

    if (addAnimation && statusDirectional != Directional.MOVE_TOP) {
      if (animRunTop != null) {
        animation = animRunTop;
      } else {
        if (_statusHorizontalDirectional == Directional.MOVE_LEFT) {
          if (animRunLeft != null) animation = animRunLeft;
        } else {
          if (animRunRight != null) animation = animRunRight;
        }
      }
    }
    statusDirectional = Directional.MOVE_TOP;
    lastDirectional = Directional.MOVE_TOP;
  }

  void _moveRight({bool addAnimation = true, bool isDiagonal = false}) {
    double speed =
        isDiagonal ? this.speed * REDUCTION_SPEED_DIAGONAL : this.speed;
    if (position.right >= gameRef.size.width) {
      return;
    }

    Rect displacement = position.translate(speed, 0);

    if (isCollision(displacement, gameRef)) {
      return;
    }

    if (position.left < gameRef.size.width / 1.5 || gameRef.map.isMaxRight()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_RIGHT);
    }

    if (addAnimation &&
        statusDirectional != Directional.MOVE_RIGHT &&
        animRunRight != null) {
      animation = animRunRight;
    }
    statusDirectional = Directional.MOVE_RIGHT;
    lastDirectional = Directional.MOVE_RIGHT;
    _statusHorizontalDirectional = statusDirectional;
  }

  void _moveBottom({bool addAnimation = true, bool isDiagonal = false}) {
    double speed =
        isDiagonal ? this.speed * REDUCTION_SPEED_DIAGONAL : this.speed;

    if (position.bottom >= gameRef.size.height) {
      return;
    }

    Rect displacement = position.translate(0, speed);

    if (isCollision(displacement, gameRef)) {
      return;
    }

    if (position.top < gameRef.size.height / 1.9 || gameRef.map.isMaxBottom()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_BOTTOM);
    }

    if (addAnimation && statusDirectional != Directional.MOVE_BOTTOM) {
      if (animRunBottom != null) {
        animation = animRunBottom;
      } else {
        if (_statusHorizontalDirectional == Directional.MOVE_LEFT) {
          if (animRunLeft != null) animation = animRunLeft;
        } else {
          if (animRunRight != null) animation = animRunRight;
        }
      }
    }
    statusDirectional = Directional.MOVE_BOTTOM;
    lastDirectional = Directional.MOVE_BOTTOM;
  }

  void _moveLeft({bool addAnimation = true, bool isDiagonal = false}) {
    double speed =
        isDiagonal ? this.speed * REDUCTION_SPEED_DIAGONAL : this.speed;

    if (position.left <= 0) {
      return;
    }
    Rect displacement = position.translate(speed * -1, 0);

    if (isCollision(displacement, gameRef)) {
      return;
    }

    if (position.left > gameRef.size.width / 3 || gameRef.map.isMaxLeft()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_LEFT);
    }

    if (addAnimation &&
        statusDirectional != Directional.MOVE_LEFT &&
        animRunLeft != null) {
      animation = animRunLeft;
    }
    statusDirectional = Directional.MOVE_LEFT;
    lastDirectional = Directional.MOVE_LEFT;
    _statusHorizontalDirectional = statusDirectional;
  }

  void _idle() {
    if (statusDirectional != Directional.IDLE) {
      if (statusDirectional == Directional.MOVE_LEFT && animIdleLeft != null)
        animation = animIdleLeft;
      if (statusDirectional == Directional.MOVE_RIGHT && animIdleRight != null)
        animation = animIdleRight;
      if (statusDirectional == Directional.MOVE_TOP) {
        if (animIdleTop != null) {
          animation = animIdleTop;
        } else {
          if (_statusHorizontalDirectional == Directional.MOVE_LEFT) {
            if (animIdleLeft != null) animation = animIdleLeft;
          } else {
            if (animIdleRight != null) animation = animIdleRight;
          }
        }
      }

      if (statusDirectional == Directional.MOVE_BOTTOM) {
        if (animIdleBottom != null) {
          animation = animIdleBottom;
        } else {
          if (_statusHorizontalDirectional == Directional.MOVE_LEFT) {
            if (animIdleLeft != null) animation = animIdleLeft;
          } else {
            if (animIdleRight != null) animation = animIdleRight;
          }
        }
      }
    }
    statusDirectional = Directional.IDLE;
  }

  void _moveBottomRight() {
    _moveRight(isDiagonal: true);
    _moveBottom(addAnimation: false, isDiagonal: true);
  }

  void _moveBottomLeft() {
    _moveLeft(isDiagonal: true);
    _moveBottom(addAnimation: false, isDiagonal: true);
  }

  void _moveTopLeft() {
    _moveLeft(isDiagonal: true);
    _moveTop(addAnimation: false, isDiagonal: true);
  }

  void _moveTopRight() {
    _moveRight(isDiagonal: true);
    _moveTop(addAnimation: false, isDiagonal: true);
  }

  void receiveDamage(double damage) {
    if (life > 0) {
      life -= damage;
      if (life <= 0) {
        die();
      }
    }
  }

  void die() {
    _isDie = true;
  }

  bool get isDie => _isDie;

  void simpleAttackMelee(
    double damage, {
    FlameAnimation.Animation attackRightAnim,
    FlameAnimation.Animation attackBottomAnim,
    FlameAnimation.Animation attackLeftAnim,
    FlameAnimation.Animation attackTopAnim,
  }) {
    Rect positionAttack;
    FlameAnimation.Animation anim = attackRightAnim;
    double pushLeft = 0;
    double pushTop = 0;
    switch (lastDirectional) {
      case Directional.MOVE_TOP:
        positionAttack =
            Rect.fromLTWH(position.left, position.top - size, size, size);
        anim = attackTopAnim;
        pushTop = size * -1;
        break;
      case Directional.MOVE_TOP_LEFT:
        break;
      case Directional.MOVE_TOP_RIGHT:
        break;
      case Directional.MOVE_RIGHT:
        positionAttack =
            Rect.fromLTWH(position.left + size, position.top, size, size);
        anim = attackRightAnim;
        pushLeft = size;
        break;
      case Directional.MOVE_BOTTOM:
        positionAttack =
            Rect.fromLTWH(position.left, position.top + size, size, size);
        anim = attackBottomAnim;
        pushTop = size;
        break;
      case Directional.MOVE_BOTTOM_RIGHT:
        break;
      case Directional.MOVE_BOTTOM_LEFT:
        break;
      case Directional.MOVE_LEFT:
        positionAttack =
            Rect.fromLTWH(position.left - size, position.top, size, size);
        anim = attackLeftAnim;
        pushLeft = size * -1;
        break;
      case Directional.IDLE:
        break;
    }

    gameRef.add(AnimatedObjectOnce(animation: anim, position: positionAttack));

    gameRef.enemies.where((i) => i.isVisibleInMap()).forEach((enemy) {
      if (enemy.position.overlaps(positionAttack)) {
        enemy.life -= damage;
        if (enemy.life < 0) {
          enemy.life = 0;
        }
        enemy.translate(pushLeft, pushTop);
      }
    });
  }
}
