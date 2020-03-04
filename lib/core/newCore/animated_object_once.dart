import 'dart:ui';

import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/component.dart';

class AnimatedObjectOnce extends Component {
  final Rect position;
  final FlameAnimation.Animation animation;
  bool _isDestroyed = false;

  AnimatedObjectOnce({this.position, this.animation});

  @override
  void render(Canvas canvas) {
    if (animation == null) return;
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  @override
  void update(double dt) {
    if (animation != null) {
      animation.update(dt);
      if (animation.isLastFrame) {
        remove();
      }
    }
  }

  @override
  bool destroy() {
    return _isDestroyed;
  }

  void remove() {
    _isDestroyed = true;
  }
}
