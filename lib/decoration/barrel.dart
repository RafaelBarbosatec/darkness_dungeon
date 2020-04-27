import 'package:bonfire/bonfire.dart';

class Barrel extends GameDecoration {
  Barrel(Position position)
      : super.sprite(Sprite('itens/barrel.png'),
            initPosition: position,
            width: 32,
            height: 32,
            collision: Collision(
              width: 24,
              height: 28,
              align: CollisionAlign.TOP_CENTER,
            ));
}
