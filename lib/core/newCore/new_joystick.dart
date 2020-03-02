import 'dart:math';
import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class NewJoystick extends JoystickController {
  double backgroundAspectRatio = 2.2;
  Rect backgroundRect;
  Sprite backgroundSprite;

  double knobAspectRatio = 1.5;
  Rect knobRect;
  Sprite knobSprite;

  double attackAspectRatio = 2.0;
  Rect attackRect;
  Sprite attackSprite;

  bool dragging = false;
  Offset dragPosition;

  double sensitivity = 6;

  final double tileSize;
  final Size screenSize;

  NewJoystick(
    this.screenSize,
    this.tileSize,
  ) {
    backgroundSprite = Sprite('joystick_background.png');
    knobSprite = Sprite('joystick_knob.png');
    attackSprite = Sprite('joystick_atack.png');

    initialize();
  }

  void initialize() async {}

  void render(Canvas canvas) {
    if (dragging) {
      backgroundSprite.renderRect(canvas, backgroundRect);
      knobSprite.renderRect(canvas, knobRect);
    }

    attackSprite.renderRect(canvas, attackRect);
  }

  void update(double t) {
    var radiusAttack = (tileSize * attackAspectRatio) / 2;

    Offset atacknob = Offset(screenSize.width - radiusAttack * 2,
        screenSize.height - (radiusAttack * 2));

    attackRect = Rect.fromCircle(
      center: atacknob,
      radius: radiusAttack,
    );

    if (dragging) {
      double _radAngle = atan2(dragPosition.dy - backgroundRect.center.dy,
          dragPosition.dx - backgroundRect.center.dx);

      // Update playerShip's player rad angle
      //game.playerShip.lastMoveRadAngle = _radAngle;

      // Distance between the center of joystick background & drag position
      Point p = Point(backgroundRect.center.dx, backgroundRect.center.dy);
      double dist = p.distanceTo(Point(dragPosition.dx, dragPosition.dy));

      bool mRight = false;
      bool mLeft = false;
      bool mTop = false;
      bool mBottom = false;

      var diffY = dragPosition.dy - backgroundRect.center.dy;
      var diffX = dragPosition.dx - backgroundRect.center.dx;
      if (dragPosition.dx > backgroundRect.center.dx &&
          diffX > backgroundRect.width / sensitivity) {
        mRight = true;
      }
      if (dragPosition.dx < backgroundRect.center.dx &&
          diffX < (-1 * backgroundRect.width / sensitivity)) {
        mLeft = true;
      }
      if (dragPosition.dy > backgroundRect.center.dy &&
          diffY > backgroundRect.height / sensitivity) {
        mBottom = true;
      }
      if (dragPosition.dy < backgroundRect.center.dy &&
          diffY < (-1 * backgroundRect.height / sensitivity)) {
        mTop = true;
      }

      if (mRight && mTop) {
        mRight = false;
        mTop = false;
        joystickListener.joystickChangeDirectional(Directional.MOVE_TOP_RIGHT);
      }

      if (mRight && mBottom) {
        mRight = false;
        mBottom = false;
        joystickListener
            .joystickChangeDirectional(Directional.MOVE_BOTTOM_RIGHT);
      }

      if (mLeft && mTop) {
        mLeft = false;
        mTop = false;
        joystickListener.joystickChangeDirectional(Directional.MOVE_TOP_LEFT);
      }

      if (mLeft && mBottom) {
        mLeft = false;
        mBottom = false;
        joystickListener
            .joystickChangeDirectional(Directional.MOVE_BOTTOM_LEFT);
      }

      if (mRight) {
        joystickListener.joystickChangeDirectional(Directional.MOVE_RIGHT);
      }

      if (mLeft) {
        joystickListener.joystickChangeDirectional(Directional.MOVE_LEFT);
      }

      if (mBottom) {
        joystickListener.joystickChangeDirectional(Directional.MOVE_BOTTOM);
      }

      if (mTop) {
        joystickListener.joystickChangeDirectional(Directional.MOVE_TOP);
      }

      // The maximum distance for the knob position the edge of
      // the background + half of its own size. The knob can wander in the
      // background image, but not outside.
      dist = dist < (tileSize * backgroundAspectRatio / 3)
          ? dist
          : (tileSize * backgroundAspectRatio / 3);

      // Calculation the knob position
      double nextX = dist * cos(_radAngle);
      double nextY = dist * sin(_radAngle);
      Offset nextPoint = Offset(nextX, nextY);

      Offset diff = Offset(backgroundRect.center.dx + nextPoint.dx,
              backgroundRect.center.dy + nextPoint.dy) -
          knobRect.center;
      knobRect = knobRect.shift(diff);
    }
  }

  void onPanStart(DragStartDetails details) {
    initPositionJoystick(details.globalPosition);
    dragging = true;
  }

  void onTapDown(TapDownDetails details) {
    initPositionJoystick(details.globalPosition);
    dragging = true;
  }

  void onTapUp(TapUpDetails details) {
    dragging = false;
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (dragging) {
      dragPosition = details.globalPosition;
    }
  }

  void onPanEnd(DragEndDetails details) {
    dragging = false;
    dragPosition = backgroundRect.center;
    joystickListener.joystickChangeDirectional(Directional.IDLE);
  }

  void onTapDownAttack(TapDownDetails details) {
    if (attackRect.contains(details.globalPosition)) {
      attackAspectRatio = 1.9;
      joystickListener.joystickAction(0);
    }
  }

  void onTapUpAttack(TapUpDetails details) {
    attackAspectRatio = 2.0;
  }

  void initPositionJoystick(Offset position) {
    // The circle radius calculation that will contain the background
    // image of the joystick
    var radius = (tileSize * backgroundAspectRatio) / 2;

    Offset osBackground = position;
    backgroundRect = Rect.fromCircle(center: osBackground, radius: radius);

    // The circle radius calculation that will contain the knob
    // image of the joystick
    radius = (tileSize * knobAspectRatio) / 2;

    Offset osKnob = Offset(backgroundRect.center.dx, backgroundRect.center.dy);
    knobRect = Rect.fromCircle(center: osKnob, radius: radius);

    dragPosition = knobRect.center;
  }
}
