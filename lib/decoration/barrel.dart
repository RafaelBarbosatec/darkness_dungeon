import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';

class Barrel extends GameDecoration {
  Barrel(Position position)
      : super.sprite(Sprite('itens/barrel.png'),
            initPosition: position,
            width: tileSize,
            height: tileSize,
            collision: Collision(
              width: 24,
              height: 28,
              align: CollisionAlign.TOP_CENTER,
            ));
}
