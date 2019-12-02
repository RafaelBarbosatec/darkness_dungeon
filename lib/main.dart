
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

class GameWidget extends StatefulWidget {

  final Size size;

  GameWidget({Key key, this.size}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  DarknessDungeon game;
  final GlobalKey<HealthBarState> healthKey = GlobalKey();

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
        }
    );
    super.initState();
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
                  child: Image.asset('assets/play_again.png',height: 20,width: 100,),
                )
              ],
            ),
          );
        });

  }
}

class DarknessDungeon extends Game {
  Size size;
  final Function(double) changeLife;
  final Function(double) changeStamina;
  final Function() gameOver;
  Player player;
  MapWord map;
  Controller controller;

  DarknessDungeon(this.size, {this.changeLife, this.changeStamina, this.gameOver}){

    player = Knight(
        size,
        initX: 3,
        initY: 3,
        changeLife: changeLife,
        changeStamina: changeStamina,
        callBackdie: (){
          if(gameOver != null){
            gameOver();
          }
        }
    );

    map = MapWord(
      MyMaps.mainMap(size),
      player,
      size,
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
  }

  void resetGame(){

    player.reset(3,3);

    map.resetMap(MyMaps.mainMap(size));

  }

  @override
  void resize(Size size) {
    this.size = size;
    super.resize(size);
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
