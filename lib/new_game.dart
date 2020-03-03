import 'package:darkness_dungeon/core/newCore/new_joystick.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:darkness_dungeon/map/dungeon_map.dart';
import 'package:darkness_dungeon/player/Knight2.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class NewGame extends StatefulWidget {
  final Size size;

  const NewGame({Key key, this.size}) : super(key: key);
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  NewJoystick _joystick;
  RPGGame _game;
  @override
  void initState() {
    _joystick = NewJoystick(widget.size, widget.size.height / 10);
    _game = RPGGame(
      joystickController: _joystick,
      player: Knight2(
        initPosition: Position(5, 6),
        size: 32,
      ),
      map: DungeonMap.map(),
      decorations: DungeonMap.decorations,
      enemies: DungeonMap.enemies,
    );
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
                    onTapDown: _joystick.onTapDown,
                    onTapUp: _joystick.onTapUp,
                    child: Container()),
              ),
              Expanded(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: _joystick.onTapDownAttack,
                    onTapUp: _joystick.onTapUpAttack,
                    child: Container()),
              )
            ],
          )
        ],
      ),
    );
  }
}
