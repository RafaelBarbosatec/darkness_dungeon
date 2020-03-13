import 'package:darkness_dungeon/core/joystick/joystick2.dart';
import 'package:darkness_dungeon/core/joystick/joystick_action.dart';
import 'package:darkness_dungeon/core/rpg_game.dart';
import 'package:darkness_dungeon/map/dungeon_map.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/player/knight_interface.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final Size size;

  const Game({Key key, this.size}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Joystck2 _joystick;
  RPGGame _game;
  bool visibleGameOver = false;
  @override
  void initState() {
    _joystick = Joystck2(
      screenSize: widget.size,
      actions: [
        JoystickAction(
          actionId: 0,
          pathSprite: 'joystick_atack.png',
          size: 50,
          marginBottom: 50,
          marginRight: 50,
        ),
        JoystickAction(
          actionId: 1,
          pathSprite: 'joystick_atack_range.png',
          size: 50,
          marginTop: 50,
          marginRight: 50,
          align: JoystickActionAlign.TOP,
        )
      ],
    );
    _game = _createGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _game.widget,
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: _joystick.onPanStart,
                  onPanUpdate: _joystick.onPanUpdate,
                  onPanEnd: _joystick.onPanEnd,
                  onTapDown: (d) {
                    _joystick.onTapDown(d);
                    _game.onTapDown(d);
                  },
                  onTapUp: (d) {
                    _joystick.onTapUp(d);
                    _game.onTapUp(d);
                  },
                  onTapCancel: () {
                    _joystick.onTapCancel();
                  },
                  child: Container(),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (d) {
                    _joystick.onTapDownAttack(d);
                    _game.onTapDown(d);
                  },
                  onTapUp: (d) {
                    _joystick.onTapUpAttack(d);
                    _game.onTapUp(d);
                  },
                  onTapCancel: () {
                    _joystick.onTapCancel();
                  },
                  child: Container(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  RPGGame _createGame() {
    return RPGGame(
      context: context,
      joystickController: _joystick,
      player: Knight(
        initPosition: Position(5, 6),
      ),
      interface: KnightInterface(),
      map: DungeonMap.map(),
      decorations: DungeonMap.decorations(),
      enemies: DungeonMap.enemies(),
    )..addListener((game) {
        if (game.player.isDead && !visibleGameOver) {
          _showDialogGameOver();
        }
      });
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
                    setState(() {
                      _game = _createGame();
                    });

                    Future.delayed(Duration(seconds: 1), () {
                      visibleGameOver = false;
                    });

                    Navigator.pop(context);
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
