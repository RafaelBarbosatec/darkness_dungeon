import 'dart:ui';

import 'package:darkness_dungeon/core/rpg_game.dart';
import 'package:darkness_dungeon/core/util/animated_object.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

export 'package:darkness_dungeon/core/decoration/extensions.dart';

class GameDecoration extends AnimatedObject with HasGameRef<RPGGame> {
  final double height;
  final double width;
  final String spriteImg;
  final bool frontFromPlayer;
  final bool collision;
  final double sizeTileMap;
  final FlameAnimation.Animation animation;
  final Position initPositionRelativeTile;
  Sprite _sprite;
  Rect positionInWorld;

  GameDecoration({
    this.spriteImg,
    this.initPositionRelativeTile,
    @required this.height,
    @required this.width,
    this.frontFromPlayer,
    this.animation,
    this.collision = false,
    this.sizeTileMap = 32,
  }) {
    this.animation = animation;
    if (spriteImg != null && spriteImg.isNotEmpty) _sprite = Sprite(spriteImg);
    position = Rect.fromLTWH(
      (initPositionRelativeTile != null ? initPositionRelativeTile.x : 0.0) *
          sizeTileMap,
      (initPositionRelativeTile != null ? initPositionRelativeTile.y : 0.0) *
          sizeTileMap,
      width,
      height,
    );
    positionInWorld = position;
  }

  @override
  void update(double dt) {
    position = Rect.fromLTWH(
      positionInWorld.left + gameRef.mapCamera.x,
      positionInWorld.top + gameRef.mapCamera.y,
      width,
      height,
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (position.top < (gameRef.size.height + height) &&
        position.top > (height * -1) &&
        position.left > (width * -1) &&
        position.left < (gameRef.size.width + width)) {
      super.render(canvas);
      if (_sprite != null && _sprite.loaded())
        _sprite.renderRect(canvas, position);
    }
  }

  bool isVisibleInMap() =>
      position.top < (gameRef.size.height + height) &&
      position.top > (height * -1) &&
      position.left > (width * -1) &&
      position.left < (gameRef.size.width + width) &&
      !destroy();
}
