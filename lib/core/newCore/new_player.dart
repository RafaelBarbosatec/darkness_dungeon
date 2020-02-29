import 'dart:ui';

import 'package:darkness_dungeon/core/map/new_object_collision.dart';
import 'package:darkness_dungeon/core/newCore/animated_object.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

class NewPlayer extends AnimatedObject
    with NewObjectCollision, HasGameRef<RPGGame>
    implements JoystickListener {
  final double size;
  final Position initPosition;
  final FlameAnimation.Animation animationIdle;
  double speed;

  NewPlayer({this.animationIdle, this.size, this.initPosition,this.speed = 5}) {
    animation = animationIdle;
    position =
        Rect.fromLTWH(initPosition.x * size, initPosition.y * size, size, size);
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

  void _moveTop() {
    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate(0, (speed * -1));

    if (position.top > gameRef.size.height / 2.9 || gameRef.map.isMaxTop()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_TOP);
    }
  }

  void _moveTopLeft() {}

  void _moveTopRight() {}

  void _moveRight() {
    if (position.right >= gameRef.size.width) {
      return;
    }
    Rect displacement = position.translate(speed, 0);
    if (position.left < gameRef.size.width / 1.5 || gameRef.map.isMaxRight()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_RIGHT);
    }
  }

  void _moveBottom() {
    if (position.bottom >= gameRef.size.height) {
      return;
    }
    Rect displacement = position.translate(0, speed);
    if (position.top < gameRef.size.height / 1.9 || gameRef.map.isMaxBottom()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_BOTTOM);
    }
  }

  void _moveBottomRight() {}

  void _moveBottomLeft() {}

  void _moveLeft() {
    if (position.left <= 0) {
      return;
    }
    Rect displacement = position.translate(speed * -1, 0);
    if (position.left > gameRef.size.width / 3 || gameRef.map.isMaxLeft()) {
      position = displacement;
    } else {
      gameRef.map.moveCamera(speed, Directional.MOVE_LEFT);
    }
  }

  void _idle() {}
}
