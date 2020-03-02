import 'package:darkness_dungeon/core/map/map_game.dart';
import 'package:darkness_dungeon/core/newCore/joystick_controller.dart';
import 'package:darkness_dungeon/core/newCore/new_enemy.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

import '../Decoration.dart';

class RPGGame extends BaseGame {
  final NewPlayer player;
  final MapGame map;
  final List<NewEnemy> enemies;
  final List<TileDecoration> decorations;
  final JoystickController joystickController;
  Position mapCamera = Position.empty();

  RPGGame({
    @required this.player,
    @required this.map,
    @required this.joystickController,
    this.enemies,
    this.decorations,
  })  : assert(
          player != null,
        ),
        assert(
          map != null,
        ),
        assert(
          joystickController != null,
        ) {
    joystickController.joystickListener = player;

    add(map);
    enemies?.forEach((enemy) {
      add(enemy);
    });
    decorations?.forEach((decoration) {
      add(decoration);
    });
    add(player);

    add(joystickController);
  }
}
