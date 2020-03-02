import 'package:darkness_dungeon/core/newCore/new_decoration.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class State1Decorations {
  static List<NewDecoration> decorations = [
    NewDecoration(
      'itens/barrel.png',
      initPosition: Position(10, 5),
      size: 32,
      collision: true,
    ),
    NewDecoration(
      'itens/table.png',
      initPosition: Position(15, 7),
      size: 32,
      collision: true,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(4, 4),
      size: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(8, 4),
      size: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(12, 4),
      size: 32,
    ),
    NewDecoration(
      '',
      animation: FlameAnimation.Animation.sequenced(
        "itens/torch_spritesheet.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      initPosition: Position(16, 4),
      size: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(6, 4),
      size: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(10, 4),
      size: 32,
    ),
    NewDecoration(
      'itens/flag_red.png',
      initPosition: Position(14, 4),
      size: 32,
    )
  ];
}
