import 'package:darkness_dungeon/core/newCore/new_enemy.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Goblin2 extends NewEnemy {
  final Position initPosition;
  final double sizeTileMap;
  Goblin2({@required this.initPosition, this.sizeTileMap = 32})
      : super(
          animationIdle: FlameAnimation.Animation.sequenced(
              "goblin_idle.png", 6,
              textureWidth: 16, textureHeight: 16),
          initPosition: initPosition,
          sizeTileMap: sizeTileMap,
          width: 25,
          height: 25,
          speed: 1.5,
        );

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
        visionCells: 5,
        closePlayer: (p) {
//          print(p);
        });
    super.update(dt);
  }
}
