import 'package:darkness_dungeon/core/newCore/new_joystick.dart';
import 'package:darkness_dungeon/core/newCore/new_map_world.dart';
import 'package:darkness_dungeon/core/newCore/new_player.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

import 'map/State1.dart';

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
      player: NewPlayer(
          animIdleRight: FlameAnimation.Animation.sequenced(
            "knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          size: 32,
          initPosition: Position(10, 10)),
      map: NewMapWorld(MyMaps.state1(widget.size)),
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
