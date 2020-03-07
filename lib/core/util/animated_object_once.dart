import 'dart:ui';

import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/component.dart';

class AnimatedObjectOnce extends Component {
  final Rect position;
  final FlameAnimation.Animation animation;
  final VoidCallback onFinish;
  final bool onlyUpdate;
  bool _isDestroyed = false;

  AnimatedObjectOnce({
    this.position,
    this.animation,
    this.onFinish,
    this.onlyUpdate = false,
  });

  @override
  void render(Canvas canvas) {
    if (animation == null || onlyUpdate) return;
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  @override
  void update(double dt) {
    if (animation != null && !_isDestroyed) {
      animation.update(dt);
      if (animation.isLastFrame) {
        if (onFinish != null) onFinish();
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
