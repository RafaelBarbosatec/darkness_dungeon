import 'dart:ui';

import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/component.dart';

class AnimatedObject extends Component {
  Rect position;

  FlameAnimation.Animation animation;

  @override
  void render(Canvas canvas) {
    if (animation == null) return;
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  void update(double dt) {
    if (animation != null) animation.update(dt);
  }
}
