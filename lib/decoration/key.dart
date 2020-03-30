import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/player/knight.dart';

class DoorKey extends GameDecoration {
  DoorKey(Position position)
      : super(
          spriteImg: 'itens/key_silver.png',
          initPosition: position,
          width: 32,
          height: 32,
          collision: false,
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) if (position
        .overlaps(gameRef.player.position)) {
      (gameRef.player as Knight).containKey = true;
      remove();
    }
  }
}
