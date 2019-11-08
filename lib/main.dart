
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
  GameWidget({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = DarknessDungeon(
        size,
        recieveDamage: (damage){
          healthKey.currentState.updateHealth(damage);
        }
    );
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: game.onPanStart,
        onPanUpdate: game.onPanUpdate,
        onPanEnd: game.onPanEnd,
        child: Stack(
          children: <Widget>[
            game.widget,
            Align(
              alignment: Alignment.topLeft,
              child: HealthBar(
                key: healthKey
              ),
            ),
            ],
        ));
  }
}

class DarknessDungeon extends Game {
  final Size size;
  final Function(double) recieveDamage;
  Player player;
  MapWord map;
  bool playerIsRun = false;
  Controller controller;

  DarknessDungeon(this.size, {this.recieveDamage}){

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
    );
    
    player = Knight(
        size,
        initX: size.width/5 - Knight.SIZE,
        initY: size.height/3 - Knight.SIZE,
        changeLife: recieveDamage
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

  void onPanStart(DragStartDetails details) {
    controller.onPanStart(details);
  }

  void onPanUpdate(DragUpdateDetails details) {
    controller.onPanUpdate(details);
  }

  void onPanEnd(DragEndDetails details) {
    controller.onPanEnd(details);
  }
}
