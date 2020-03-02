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
  final FlameAnimation.Animation animation;
  final Position initPosition;
  Sprite _sprite;

  NewDecoration(
      {this.initPosition,
      this.size,
      this.spriteImg,
      this.frontFromPlayer,
      this.animation}) {
    this.animation = animation;
    if (spriteImg.isNotEmpty) _sprite = Sprite(spriteImg);
    position = Rect.fromLTWH(
      (initPosition != null ? initPosition.x : 0.0) * size,
      (initPosition != null ? initPosition.y : 0.0) * size,
      size,
      size,
    );
  }
}
