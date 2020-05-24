import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/interface/knight_interface.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/map/dungeon_map.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/dialogs.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  bool showGameOver = false;

  GameController _controller;

  @override
  void initState() {
    _controller = GameController()..setListener(this);
    Sounds.playBackgroundSound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    tileSize = ((sizeScreen.height < sizeScreen.width)
            ? sizeScreen.height
            : sizeScreen.width) /
        9;
    tileSize = tileSize.roundToDouble();

    return BonfireWidget(
      gameController: _controller,
      joystick: Joystick(
        directional: JoystickDirectional(
          spriteBackgroundDirectional: Sprite('joystick_background.png'),
          spriteKnobDirectional: Sprite('joystick_knob.png'),
          size: 100,
          isFixed: false,
        ),
        actions: [
          JoystickAction(
            actionId: 0,
            sprite: Sprite('joystick_atack.png'),
            spritePressed: Sprite('joystick_atack_selected.png'),
            size: 80,
            margin: EdgeInsets.only(bottom: 50, right: 50),
          ),
          JoystickAction(
            actionId: 1,
            sprite: Sprite('joystick_atack_range.png'),
            spritePressed: Sprite('joystick_atack_range_selected.png'),
            size: 50,
            margin: EdgeInsets.only(bottom: 50, right: 160),
          )
        ],
      ),
      player: Knight(
        initPosition: Position(5 * tileSize, 6 * tileSize),
      ),
      interface: KnightInterface(),
      map: DungeonMap.map(),
      decorations: DungeonMap.decorations(),
      enemies: DungeonMap.enemies(),
      lightingColorGame: Colors.black.withOpacity(0.5),
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

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player.isDead) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
}
