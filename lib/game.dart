import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/map/dungeon_map.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/player/knight_interface.dart';
import 'package:darkness_dungeon/util/dialogs.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool showGameOver = false;
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(
        pathSpriteBackgroundDirectional: 'joystick_background.png',
        pathSpriteKnobDirectional: 'joystick_knob.png',
        sizeDirectional: 100,
        actions: [
          JoystickAction(
            actionId: 0,
            pathSprite: 'joystick_atack.png',
            pathSpritePressed: 'joystick_atack_selected.png',
            size: 80,
            marginBottom: 50,
            marginRight: 50,
          ),
          JoystickAction(
            actionId: 1,
            pathSprite: 'joystick_atack_range.png',
            pathSpritePressed: 'joystick_atack_range_selected.png',
            size: 50,
            marginBottom: 50,
            marginRight: 160,
          )
        ],
      ),
      player: Knight(
        initPosition: Position(5 * 32.0, 6 * 32.0),
      ),
      interface: KnightInterface(),
      map: DungeonMap.map(),
      decorations: DungeonMap.decorations(),
      enemies: DungeonMap.enemies(),
      listener: (context, game) {
        if (game.player.isDead) {
          if (!showGameOver) {
            showGameOver = true;
            _showDialogGameOver();
          }
        }
      },
    );
  }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Game()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
