import 'dart:ui';

import 'package:darkness_dungeon/core/map/new_object_collision.dart';
import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import 'joystick_controller.dart';

class NewPlayer extends AnimatedObject
    with NewObjectCollision, HasGameRef<RPGGame>
    implements JoystickListener {
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
  Directional _statusDirectional;
  Directional _statusHorizontalDirectional = Directional.MOVE_RIGHT;

  NewPlayer({
    this.animIdleLeft,
    this.animIdleRight,
    this.animIdleTop,
    this.animIdleBottom,
    this.animRunTop,
    this.animRunRight,
    this.animRunBottom,
    this.animRunLeft,
    this.size = 0,
    this.initPosition,
    this.initDirectional = Directional.MOVE_RIGHT,
    this.speed = 5,
    this.life = 10,
  }) {
    _statusDirectional = initDirectional;

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
    print(action);
  }

  @override
  void joystickChangeDirectional(Directional directional) {
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

  void _moveTop({bool addAnimation = true}) {
    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate(0, (speed * -1));

    if (position.top > gameRef.size.height / 2.9 || gameRef.map.isMaxTop()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_TOP);
    }

    if (addAnimation &&
        _statusDirectional != Directional.MOVE_TOP &&
        animRunTop != null) {
      animation = animRunTop;
    }
    _statusDirectional = Directional.MOVE_TOP;
  }

  void _moveRight({bool addAnimation = true}) {
    if (position.right >= gameRef.size.width) {
      return;
    }
    Rect displacement = position.translate(speed, 0);
    if (position.left < gameRef.size.width / 1.5 || gameRef.map.isMaxRight()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_RIGHT);
    }

    if (addAnimation &&
        _statusDirectional != Directional.MOVE_RIGHT &&
        animRunRight != null) {
      animation = animRunRight;
    }
    _statusDirectional = Directional.MOVE_RIGHT;
    _statusHorizontalDirectional = _statusDirectional;
  }

  void _moveBottom({bool addAnimation = true}) {
    if (position.bottom >= gameRef.size.height) {
      return;
    }
    Rect displacement = position.translate(0, speed);
    if (position.top < gameRef.size.height / 1.9 || gameRef.map.isMaxBottom()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_BOTTOM);
    }

    if (addAnimation &&
        _statusDirectional != Directional.MOVE_BOTTOM &&
        animRunBottom != null) {
      animation = animRunBottom;
    }
    _statusDirectional = Directional.MOVE_BOTTOM;
  }

  void _moveLeft({bool addAnimation = true}) {
    if (position.left <= 0) {
      return;
    }
    Rect displacement = position.translate(speed * -1, 0);
    if (position.left > gameRef.size.width / 3 || gameRef.map.isMaxLeft()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_LEFT);
    }

    if (addAnimation &&
        _statusDirectional != Directional.MOVE_LEFT &&
        animRunLeft != null) {
      animation = animRunLeft;
    }
    _statusDirectional = Directional.MOVE_LEFT;
    _statusHorizontalDirectional = _statusDirectional;
  }

  void _idle() {
    if (_statusDirectional != Directional.IDLE) {
      if (_statusDirectional == Directional.MOVE_LEFT && animIdleLeft != null)
        animation = animIdleLeft;
      if (_statusDirectional == Directional.MOVE_RIGHT && animIdleRight != null)
        animation = animIdleRight;
      if (_statusDirectional == Directional.MOVE_TOP) {
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

      if (_statusDirectional == Directional.MOVE_BOTTOM) {
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
    _statusDirectional = Directional.IDLE;
  }

  void _moveBottomRight() {
    _moveRight();
    _moveBottom(addAnimation: false);
  }

  void _moveBottomLeft() {
    _moveLeft();
    _moveBottom(addAnimation: false);
  }

  void _moveTopLeft() {
    _moveLeft();
    _moveTop(addAnimation: false);
  }

  void _moveTopRight() {
    _moveRight();
    _moveTop(addAnimation: false);
  }
}
