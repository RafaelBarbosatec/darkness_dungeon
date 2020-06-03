import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';

class Barrel extends GameDecoration {
  Barrel(Position position)
      : super.sprite(Sprite('itens/barrel.png'),
            initPosition: position,
            width: tileSize,
            height: tileSize,
            collision: Collision(
              width: tileSize * 0.6,
              height: tileSize * 0.8,
              align: CollisionAlign.TOP_CENTER,
            ));
}
