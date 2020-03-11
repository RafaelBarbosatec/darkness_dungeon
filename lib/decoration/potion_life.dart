import 'package:darkness_dungeon/core/decoration/decoration.dart';
import 'package:flame/position.dart';

class PotionLife extends GameDecoration {
  final Position initPosition;

  PotionLife(this.initPosition)
      : super(
          spriteImg: 'itens/potion_life.png',
          initPositionRelativeTile: getPosition(initPosition),
          width: 10,
          height: 10,
        );

  @override
  void update(double dt) {
    this.seePlayer(
        observed: (player) {
          player.addLife(40);
          remove();
        },
        visionCells: 1);
    super.update(dt);
  }

  static Position getPosition(Position position) {
    return Position(
      position.x / 32,
      position.y / 32,
    );
  }
}
