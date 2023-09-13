import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';

class PotionLife extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final double life;
  bool hasContact = false;

  PotionLife(this.initPosition, this.life)
      : super.withSprite(
          sprite: Sprite.load('items/potion_red.png'),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        );

  @override
  void onContact(GameComponent collision) {
    if (collision is Player && !hasContact) {
      hasContact = true;
      gameRef.player?.addLife(100);
      removeFromParent();
    }
  }
}
