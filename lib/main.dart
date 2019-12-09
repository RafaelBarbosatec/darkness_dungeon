
import 'dart:async';

import 'package:darkness_dungeon/Menu.dart';
import 'package:darkness_dungeon/player/HealthBar.dart';
import 'package:darkness_dungeon/core/Controller.dart';
import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/map/State1.dart';
import 'package:darkness_dungeon/player/Knight.dart';
import 'package:darkness_dungeon/core/Player.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

void main() async {
  await Flame.util.setLandscape();
  await Flame.util.fullScreen();
  runApp(MaterialApp(
    home: Menu(),
  ));
}

class GameWidget extends StatefulWidget {

  final Size size;

  GameWidget({Key key, this.size}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  DarknessDungeon game;
  final GlobalKey<HealthBarState> healthKey = GlobalKey();
  StreamController<bool> streamProgress = StreamController();

  @override
  void initState() {
    game = DarknessDungeon(
        widget.size,
        changeLife: (damage){
          healthKey.currentState.updateHealth(damage);
        },
        changeStamina: (stamina){
          healthKey.currentState.updateStamina(stamina);
        },
        gameOver: (){
          _showDialogGameOver();
        },
        loaded: (){
          Future.delayed(Duration(milliseconds: 500),(){
            streamProgress.sink.add(false);
          });
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          game.widget,
          Align(
            alignment: Alignment.topLeft,
            child: HealthBar(
                key: healthKey
            ),
          ),
          _buildProgress(),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: game.controller.onPanStart,
                    onPanUpdate: game.controller.onPanUpdate,
                    onPanEnd: game.controller.onPanEnd,
                    onTapDown: game.controller.onTapDown,
                    onTapUp: game.controller.onTapUp,
                    child: Container()),
              ),
              Expanded(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: game.controller.onTapDownAtack,
                    onTapUp: game.controller.onTapUpAtack,
                    child: Container()),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDialogGameOver() {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/game_over.png',height: 100,),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  onPressed: (){
                    healthKey.currentState.updateHealth(100);
                    healthKey.currentState.updateStamina(100);
                    game.resetGame();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0
                    ),
                  ),
                )
              ],
            ),
          );
        });

  }

  Widget _buildProgress() {

    return StreamBuilder(
      stream: streamProgress.stream,
      initialData: true,
      builder: (context,snapshot){
        bool showProgress = true;

        if(snapshot.hasData){
          showProgress = snapshot.data;
        }

        return AnimatedOpacity(
          opacity: showProgress ? 1.0 : 0.0 ,
          duration: Duration(milliseconds: 500),
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "Carregando...",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Normal',
                    fontSize: 20.0
                ),
              ),
            ),
          ),
        );
      },
    );

  }

  @override
  void dispose() {
    streamProgress.close();
    super.dispose();
  }
}

class DarknessDungeon extends BaseGame {
  Size size;
  final Function(double) changeLife;
  final Function(double) changeStamina;
  final Function() gameOver;
  final Function() loaded;
  Player player;
  MapWord map;
  Controller controller;
  bool loadedControl = false;

  DarknessDungeon(this.size, {this.changeLife, this.changeStamina, this.gameOver, this.loaded}){

    player = Knight(
        size,
        initX: 3,
        initY: 4,
        changeLife: changeLife,
        changeStamina: changeStamina,
        callBackdie: (){
          if(gameOver != null){
            gameOver();
          }
        }
    );

    map = MapWord(
      MyMaps.state1(size),
      player,
      size,
    );

    controller = Controller(
        size,
        size.height / 10,
        player.moveToTop,
        player.moveToBottom,
        player.moveToLeft,
        player.moveToRight,
        player.idle,
        player.runTopLeft,
        player.runTopRight,
        player.runBottomLeft,
        player.runBottomRight,
        player.atack
    );

    add(map);
    add(controller);
  }

  void resetGame(){

    player.reset(3,3);

    map.resetMap(MyMaps.state1(size));

  }

  @override
  void resize(Size size) {
    this.size = size;
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(!loadedControl){
      loadedControl = true;
      loaded();
    }
  }

}
