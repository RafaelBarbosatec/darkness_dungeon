import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Spikes extends GameDecoration {
  final double damage;
  bool _infligeDamage = false;
  Spikes(Position position, {this.damage = 10})
      : super(
          animation: FlameAnimation.Animation.sequenced(
            "itens/spikes.png",
            10,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPosition: position,
          width: 32,
          height: 32,
        );

  @override
  void update(double dt) {
    if (this.animation.currentIndex == this.animation.frames.length - 1 ||
        this.animation.currentIndex == this.animation.frames.length - 2) {
      if (gameRef.player != null) {
        if (gameRef.player.rectCollision.overlaps(position) &&
            !_infligeDamage) {
          _infligeDamage = true;
          gameRef.player.receiveDamage(damage);
        }
      }
    } else {
      _infligeDamage = false;
    }
    super.update(dt);
  }
}
