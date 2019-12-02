import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Controller {

  double backgroundAspectRatio = 2.2;
  Rect backgroundRect;
  Sprite backgroundSprite;

  double knobAspectRatio = 1.5;
  Rect knobRect;
  Sprite knobSprite;

  double atackAspectRatio = 2.0;
  Rect atackRect;
  Sprite atackSprite;

  bool dragging = false;
  Offset dragPosition;

  double sensitivity = 6;

  final double tileSize;
  final Size screenSize;
  final Function() moveTop;
  final Function() moveTopLeft;
  final Function() moveTopRight;
  final Function() moveBottom;
  final Function() moveBottomLeft;
  final Function() moveBottomRight;
  final Function() moveLeft;
  final Function() moveRight;
  final Function() idle;
  final Function() atack;

  Controller(
      this.screenSize,
      this.tileSize,
      this.moveTop,
      this.moveBottom,
      this.moveLeft,
      this.moveRight,
      this.idle,
      this.moveTopLeft,
      this.moveTopRight,
      this.moveBottomLeft,
      this.moveBottomRight,
      this.atack) {
    backgroundSprite = Sprite('joystick_background.png');
    knobSprite = Sprite('joystick_knob.png');
    atackSprite = Sprite('joystick_atack.png');

    initialize();
  }

  void initialize() async {

  }

  void render(Canvas canvas) {
    if(dragging){
      backgroundSprite.renderRect(canvas, backgroundRect);
      knobSprite.renderRect(canvas, knobRect);
    }

    atackSprite.renderRect(canvas, atackRect);
  }

  void update(double t) {
    //Button Atack

    var radiusAtack = (tileSize * atackAspectRatio) / 2;

    Offset atacknob = Offset(
        screenSize.width - radiusAtack*2,
        screenSize.height - (radiusAtack*2)
    );

    atackRect = Rect.fromCircle(
        center: atacknob,
        radius: radiusAtack
    );


    if (dragging) {

      double _radAngle = atan2(
          dragPosition.dy - backgroundRect.center.dy,
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
      if(dragPosition.dx > backgroundRect.center.dx && diffX > backgroundRect.width /sensitivity){
        mRight = true;
      }
      if(dragPosition.dx < backgroundRect.center.dx && diffX < (-1 * backgroundRect.width /sensitivity)){
        mLeft = true;
      }
      if(dragPosition.dy > backgroundRect.center.dy && diffY > backgroundRect.height /sensitivity){
        mBottom = true;
      }
      if(dragPosition.dy < backgroundRect.center.dy && diffY < (-1 * backgroundRect.height /sensitivity)){
        mTop = true;
      }

      if(mRight && mTop){
        mRight = false;
        mTop = false;
        moveTopRight();
      }

      if(mRight && mBottom){
        mRight = false;
        mBottom = false;
        moveBottomRight();
      }

      if(mLeft && mTop){
        mLeft = false;
        mTop = false;
        moveTopLeft();
      }

      if(mLeft && mBottom){
        mLeft = false;
        mBottom = false;
        moveBottomLeft();
      }

      if(mRight){
        moveRight();
      }

      if(mLeft){
        moveLeft();
      }

      if(mBottom){
        moveBottom();
      }

      if(mTop){
        moveTop();
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

      Offset diff = Offset(
          backgroundRect.center.dx + nextPoint.dx,
          backgroundRect.center.dy + nextPoint.dy) - knobRect.center;
      knobRect = knobRect.shift(diff);

    }
  }

  void onPanStart(DragStartDetails details) {
      initPositionJoystick(details.globalPosition);
      dragging = true;
  }

  void onTapDown(TapDownDetails details){
      initPositionJoystick(details.globalPosition);
      dragging = true;
  }

  void onTapUp(TapUpDetails details){
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
    idle();
  }

  void onTapDownAtack(TapDownDetails details){
    if (atackRect.contains(details.globalPosition)) {
      atackAspectRatio = 1.95;
      atack();
    }
  }

  void onTapUpAtack(TapUpDetails details){
    atackAspectRatio = 2.0;
  }

  void initPositionJoystick(Offset position) {
    // The circle radius calculation that will contain the background
    // image of the joystick
    var radius = (tileSize * backgroundAspectRatio) / 2;

    Offset osBackground = position;
    backgroundRect = Rect.fromCircle(
        center: osBackground,
        radius: radius
    );

    // The circle radius calculation that will contain the knob
    // image of the joystick
    radius = (tileSize * knobAspectRatio) / 2;

    Offset osKnob = Offset(
        backgroundRect.center.dx,
        backgroundRect.center.dy
    );
    knobRect = Rect.fromCircle(
        center: osKnob,
        radius: radius
    );

    dragPosition = knobRect.center;
  }

}