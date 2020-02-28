import 'package:darkness_dungeon/core/map/map_game.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:flame/game.dart';

import '../Decoration.dart';
import '../Enemy.dart';

class RPGGame extends BaseGame {
  final NewPlayer player;
  final MapGame map;
  final List<Enemy> enemies;
  final List<TileDecoration> decorations;

  RPGGame({this.player, this.map, this.enemies, this.decorations}) {
    add(player);
  }
}
