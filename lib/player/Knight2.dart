import 'dart:ui';

import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Knight2 extends NewPlayer {
  final double size;
  final Position initPosition;

  Knight2({
    this.size,
    this.initPosition,
  }) : super(
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleRight: FlameAnimation.Animation.sequenced(
            "knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          size: size,
          initPosition: initPosition,
        ) {
    speed = 3;
  }

  @override
  void joystickAction(int action) {
    super.joystickAction(action);
    print("print 2");
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}
