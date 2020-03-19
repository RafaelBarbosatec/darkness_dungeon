import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/map/dungeon_map.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/player/knight_interface.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool visibleGameOver = false;
  static const sizeTile = 32.0;

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
            size: 80,
            marginBottom: 50,
            marginRight: 50,
          ),
          JoystickAction(
            actionId: 1,
            pathSprite: 'joystick_atack_range.png',
            size: 50,
            marginBottom: 50,
            marginRight: 160,
          )
        ],
      ),
      player: Knight(
        initPosition: Position(5 * sizeTile, 6 * sizeTile),
      ),
      interface: KnightInterface(),
      map: DungeonMap.map(),
      decorations: DungeonMap.decorations(),
      enemies: DungeonMap.enemies(),
      listener: (context, game) {
        if (game.player.isDead && !visibleGameOver) {
          _showDialogGameOver();
        }
      },
    );
  }

  void _showDialogGameOver() {
    setState(() {
      visibleGameOver = true;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/game_over.png',
                  height: 100,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Game()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 20.0),
                  ),
                )
              ],
            ),
          );
        });
  }
}
