import 'dart:math';
import 'dart:ui';

import 'package:darkness_dungeon/core/joystick/joystick_action.dart';
import 'package:darkness_dungeon/core/util/joystick_controller.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class Joystck2 extends JoystickController {
  double _backgroundAspectRatio = 2.2;
  Rect _backgroundRect;
  Sprite _backgroundSprite;

  Rect _knobRect;
  Sprite _knobSprite;

  bool _dragging = false;
  Offset _dragPosition;

  double _sensitivity = 6;

  double _tileSize;
  final Size screenSize;

  final double sizeDirectional;
  final double marginBottomDirectional;
  final double marginLeftDirectional;
  final String pathSpriteBackgroundDirectional;
  final String pathSpriteKnobDirectional;

  final List<JoystickAction> actions;

  Joystck2({
    @required this.screenSize,
    this.actions,
    this.sizeDirectional = 80,
    this.marginBottomDirectional = 100,
    this.marginLeftDirectional = 100,
    this.pathSpriteBackgroundDirectional = 'joystick_background.png',
    this.pathSpriteKnobDirectional = 'joystick_knob.png',
  }) {
    _backgroundSprite = Sprite(pathSpriteBackgroundDirectional);
    _knobSprite = Sprite(pathSpriteKnobDirectional);
    _tileSize = sizeDirectional / 2;
    initialize();
  }

  void initialize() async {
    Offset osBackground = Offset(
        marginLeftDirectional, screenSize.height - marginBottomDirectional);
    _backgroundRect =
        Rect.fromCircle(center: osBackground, radius: sizeDirectional / 2);

    Offset osKnob =
        Offset(_backgroundRect.center.dx, _backgroundRect.center.dy);
    _knobRect = Rect.fromCircle(center: osKnob, radius: sizeDirectional / 4);

    _dragPosition = _knobRect.center;

    if (actions != null) {
      actions.forEach((action) {
        double radius = action.size / 2;
        action.rect = Rect.fromCircle(
          center: Offset(
            screenSize.width - (action.marginRight + radius),
            (action.align == JoystickActionAlign.TOP ? 0 : screenSize.height) +
                (action.align == JoystickActionAlign.TOP
                    ? (action.marginTop + radius)
                    : ((action.marginBottom + radius) * -1)),
          ),
          radius: radius,
        );
      });
    }
  }

  void render(Canvas canvas) {
    _backgroundSprite.renderRect(canvas, _backgroundRect);
    _knobSprite.renderRect(canvas, _knobRect);

    actions.forEach((action) => action.render(canvas));
  }

  void update(double t) {
    if (_dragging) {
      double _radAngle = atan2(_dragPosition.dy - _backgroundRect.center.dy,
          _dragPosition.dx - _backgroundRect.center.dx);

      // Distance between the center of joystick background & drag position
      Point p = Point(_backgroundRect.center.dx, _backgroundRect.center.dy);
      double dist = p.distanceTo(Point(_dragPosition.dx, _dragPosition.dy));

      bool mRight = false;
      bool mLeft = false;
      bool mTop = false;
      bool mBottom = false;

      var diffY = _dragPosition.dy - _backgroundRect.center.dy;
      var diffX = _dragPosition.dx - _backgroundRect.center.dx;
      if (_dragPosition.dx > _backgroundRect.center.dx &&
          diffX > _backgroundRect.width / _sensitivity) {
        mRight = true;
      }
      if (_dragPosition.dx < _backgroundRect.center.dx &&
          diffX < (-1 * _backgroundRect.width / _sensitivity)) {
        mLeft = true;
      }
      if (_dragPosition.dy > _backgroundRect.center.dy &&
          diffY > _backgroundRect.height / _sensitivity) {
        mBottom = true;
      }
      if (_dragPosition.dy < _backgroundRect.center.dy &&
          diffY < (-1 * _backgroundRect.height / _sensitivity)) {
        mTop = true;
      }

      if (mRight && mTop) {
        mRight = false;
        mTop = false;
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_TOP_RIGHT);
      }

      if (mRight && mBottom) {
        mRight = false;
        mBottom = false;
        joystickListener.joystickChangeDirectional(
            JoystickMoveDirectional.MOVE_BOTTOM_RIGHT);
      }

      if (mLeft && mTop) {
        mLeft = false;
        mTop = false;
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_TOP_LEFT);
      }

      if (mLeft && mBottom) {
        mLeft = false;
        mBottom = false;
        joystickListener.joystickChangeDirectional(
            JoystickMoveDirectional.MOVE_BOTTOM_LEFT);
      }

      if (mRight) {
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_RIGHT);
      }

      if (mLeft) {
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_LEFT);
      }

      if (mBottom) {
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_BOTTOM);
      }

      if (mTop) {
        joystickListener
            .joystickChangeDirectional(JoystickMoveDirectional.MOVE_TOP);
      }

      // The maximum distance for the knob position the edge of
      // the background + half of its own size. The knob can wander in the
      // background image, but not outside.
      dist = dist < (_tileSize * _backgroundAspectRatio / 3)
          ? dist
          : (_tileSize * _backgroundAspectRatio / 3);

      // Calculation the knob position
      double nextX = dist * cos(_radAngle);
      double nextY = dist * sin(_radAngle);
      Offset nextPoint = Offset(nextX, nextY);

      Offset diff = Offset(_backgroundRect.center.dx + nextPoint.dx,
              _backgroundRect.center.dy + nextPoint.dy) -
          _knobRect.center;
      _knobRect = _knobRect.shift(diff);
    } else {
      Offset diff = _dragPosition - _knobRect.center;
      _knobRect = _knobRect.shift(diff);
    }
  }

  void onPanStart(DragStartDetails details) {
    _dragging = true;
  }

  void onTapDown(TapDownDetails details) {
    _dragging = true;
  }

  void onTapUp(TapUpDetails details) {
    _dragging = false;
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (_dragging) {
      _dragPosition = details.globalPosition;
    }
  }

  void onPanEnd(DragEndDetails details) {
    _dragging = false;
    _dragPosition = _backgroundRect.center;
    joystickListener.joystickChangeDirectional(JoystickMoveDirectional.IDLE);
  }

  void onTapDownAttack(TapDownDetails details) {
    actions
        .where((action) => action.rect.contains(details.globalPosition))
        .forEach((action) {
      action.pressed();
      joystickListener.joystickAction(action.actionId);
    });
  }

  void onTapUpAttack(TapUpDetails details) {
    actions.forEach((action) {
      action.unPressed();
    });
  }

  void onTapCancel() {
    actions.forEach((action) {
      action.unPressed();
    });
  }
}
