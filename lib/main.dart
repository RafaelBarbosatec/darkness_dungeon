
import 'package:darkness_dungeon/HealthBar.dart';
import 'package:darkness_dungeon/core/Controller.dart';
import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/map/MyMaps.dart';
import 'package:darkness_dungeon/player/Knight.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey<HealthBarState> healthKey = GlobalKey();
  DarknessDungeon game;

  GameWidget({Key key, this.size}) : super(key: key){
    game = DarknessDungeon(
        size,
        recieveDamage: (damage){
          healthKey.currentState.updateHealth(damage);
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        game.widget,
        Align(
          alignment: Alignment.topLeft,
          child: HealthBar(
              key: healthKey
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: game.controller.onPanStart,
                  onPanUpdate: game.controller.onPanUpdate,
                  onPanEnd: game.controller.onPanEnd,
                  child: Container()),
            ),
            Expanded(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: game.controller.onTapDown,
                  onTapUp: game.controller.onTapUp,
                  child: Container()),
            )
          ],
        )
      ],
    );
  }
}

class DarknessDungeon extends Game {
  final Size size;
  final Function(double) recieveDamage;
  Player player;
  MapWord map;
  Controller controller;

  DarknessDungeon(this.size, {this.recieveDamage}){

    player = Knight(
        size,
        initX: size.width/5 - Knight.SIZE,
        initY: size.height/3 - Knight.SIZE,
        changeLife: recieveDamage
    );

    controller = Controller(
        size,
        size.height / 10,
        runTop,
        runBottom,
        runLeft,
        runRight,
        idle,
        runTopLeft,
        runTopRight,
        runBottomLeft,
        runBottomRight,
        player.atack
    );

    map = MapWord(
      MyMaps.mainMap(size),
      player,
      size,
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

  void runTopRight(){
    player.runTopRight();
  }

  void runBottomLeft(){
    player.runBottomLeft();
  }

  void runTopLeft(){
    player.runTopLeft();
  }

  void runBottomRight(){
    player.runBottomRight();
  }

  @override
  void render(Canvas canvas) {
    map.render(canvas);
    controller.render(canvas);
  }

  @override
  void update(double t) {
    map.update(t);
    controller.update(t);
  }

}
