import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class AnimationGameObject {

  Rect position;
  FlameAnimation.Animation animation;

  void render(Canvas canvas) {
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  void renderRect(Canvas canvas,Rect position) {
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  void update(double dt) {
    animation.update(dt);
  }
}