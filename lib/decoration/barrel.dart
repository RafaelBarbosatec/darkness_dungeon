import 'package:bonfire/bonfire.dart';

class Barrel extends GameDecoration {
  Barrel(Position position)
      : super(
            spriteImg: 'itens/barrel.png',
            initPosition: position,
            width: 32,
            height: 32,
            withCollision: true,
            collision: Collision(
              width: 24,
              height: 28,
              align: CollisionAlign.TOP_CENTER,
            ));
}
