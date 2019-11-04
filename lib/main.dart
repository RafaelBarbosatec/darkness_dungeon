import 'dart:math';

import 'package:darkness_dungeon/Joystick.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/map/MyMaps.dart';
import 'package:darkness_dungeon/player/Knight.dart';
import 'package:darkness_dungeon/player/Player.dart';
import 'package:darkness_dungeon/util/AnimationGameObject.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

void main() async {
  await Flame.util.setLandscape();
  await Flame.util.fullScreen();
  Size size = await Flame.util.initialDimensions();
  runApp(MaterialApp(
    home: GameWidget(
      size: size,
    ),  
  ));
}

class GameWidget extends StatelessWidget {
  final Size size;

  const GameWidget({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = DarknessDungeon(size);
    return Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            game.widget, 
            Align(
              alignment: Alignment.bottomLeft,
              child: Joystick(
                tabTop: (){
                  game.runTop();
                },
                tabBottom: (){
                  game.runBottom();
                },
                tabLeft: (){
                  game.runLeft();
                },
                tabRight: (){
                  game.runRight();
                },
                idle: (){
                  game.idle();
                },
              ),
            )
            ],
        ));
  }
}

class DarknessDungeon extends Game {
  final Size size;
  Player player;
  MapWord map;
  bool playerIsRun = false;
  final double speedPlayer = 10;
  final double sizePlayer = 30;

  DarknessDungeon(this.size){

    map = MyMaps.mainMap(size);

    player = Knight.mainPlayer(
        map,
        size,
        initX: size.width/5 - sizePlayer,
        initY: size.height/3 -sizePlayer
    );

  }

  void idle(){
    player.idle();
  }

  void runTop(){
    player.moveToTop();
  }

  void runBottom(){
    player.moveToBottom();
  }

  void runLeft(){
    player.moveToLeft();
  }

  void runRight(){
    player.moveToRight();
  }

  @override
  void render(Canvas canvas) {
    map.render(canvas);
    player.render(canvas);
  }

  @override
  void update(double t) {
    map.update(t);
    player.update(t);
  }
}
