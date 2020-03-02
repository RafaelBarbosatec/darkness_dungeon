import 'dart:ui';

import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class NewDecoration extends AnimatedGameObject with HasGameRef<RPGGame> {
  final double size;
  final String spriteImg;
  final bool frontFromPlayer;
  final bool collision;
  final FlameAnimation.Animation animation;
  final Position initPosition;
  Sprite _sprite;
  Rect _positionCurrent;

  NewDecoration(
    this.spriteImg, {
    this.initPosition,
    this.size,
    this.frontFromPlayer,
    this.animation,
    this.collision = false,
  }) {
    this.animation = animation;
    if (spriteImg.isNotEmpty) _sprite = Sprite(spriteImg);
    position = Rect.fromLTWH(
      (initPosition != null ? initPosition.x : 0.0) * size,
      (initPosition != null ? initPosition.y : 0.0) * size,
      size,
      size,
    );
    _positionCurrent = position;
  }

  @override
  void update(double dt) {
    position = Rect.fromLTWH(
      _positionCurrent.left + gameRef.mapCamera.x,
      _positionCurrent.top + gameRef.mapCamera.y,
      size,
      size,
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (position.top < (gameRef.size.height + size) &&
        position.top > (size * -1) &&
        position.left > (size * -1) &&
        position.left < (gameRef.size.width + size)) {
      super.render(canvas);
      if (_sprite != null && _sprite.loaded())
        _sprite.renderRect(canvas, position);
    }
  }
}
