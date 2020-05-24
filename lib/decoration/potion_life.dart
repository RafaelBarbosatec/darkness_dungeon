import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:flame/position.dart';

class PotionLife extends GameDecoration {
  final Position initPosition;
  final double life;
  double _lifeDistributed = 0;

  PotionLife(this.initPosition, this.life)
      : super.sprite(
          Sprite('itens/potion_red.png'),
          initPosition: initPosition,
          width: tileSize,
          height: tileSize,
        );

  @override
  void update(double dt) {
    if (gameRef.player != null &&
        position != null &&
        position.overlaps(gameRef.player.position)) {
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (_lifeDistributed >= life) {
          timer.cancel();
        } else {
          _lifeDistributed += 2;
          gameRef.player.addLife(5);
        }
      });
      remove();
    }
    super.update(dt);
  }
}
