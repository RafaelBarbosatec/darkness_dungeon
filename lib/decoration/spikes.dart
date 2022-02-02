import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';

class Spikes extends GameDecoration with Sensor {
  final double damage;

  Spikes(Vector2 position, {this.damage = 60})
      : super.withAnimation(
          animation: GameSpriteSheet.spikes(),
          position: position,
          size: Vector2(tileSize, tileSize),
        ) {
    setupSensorArea(
      // align: Vector2(valueByTileSize(2), valueByTileSize(4)),
      // size: Vector2(valueByTileSize(14), valueByTileSize(12)),
      intervalCheck: 100,
    );
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      if (this.animation?.currentIndex ==
              (this.animation?.frames.length ?? 0) - 1 ||
          this.animation?.currentIndex ==
              (this.animation?.frames.length ?? 0) - 2) {
        gameRef.player?.receiveDamage(damage, 0);
      }
    }
  }

  @override
  int get priority => LayerPriority.getComponentPriority(1);
}
