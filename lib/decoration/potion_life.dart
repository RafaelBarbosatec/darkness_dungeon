import 'package:darkness_dungeon/core/decoration/decoration.dart';
import 'package:flame/position.dart';

class PotionLife extends GameDecoration {
  final Position initPosition;

  PotionLife(this.initPosition)
      : super(
          spriteImg: 'itens/potion_life.png',
          initPosition: initPosition,
          width: 16,
          height: 16,
        );

  @override
  void update(double dt) {
    if (position.overlaps(gameRef.player.position)) {
      gameRef.player.addLife(40);
      remove();
    }
    super.update(dt);
  }
}
