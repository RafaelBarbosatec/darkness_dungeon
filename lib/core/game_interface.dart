import 'dart:ui';

import 'package:darkness_dungeon/core/rpg_game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

class GameInterface extends Component with HasGameRef<RPGGame> {
  @override
  int priority() {
    return 10;
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {}
}
