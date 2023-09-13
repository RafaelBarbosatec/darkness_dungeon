import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';

class PotionLife extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final double life;
  double _lifeDistributed = 0;
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
      generateValues(
        const Duration(seconds: 1),
        onChange: (value) {
          if (_lifeDistributed < life) {
            double newLife = life * value - _lifeDistributed;
            _lifeDistributed += newLife;
            collision.addLife(newLife.roundToDouble());
          }
        },
      );
      removeFromParent();
    }
  }
}
