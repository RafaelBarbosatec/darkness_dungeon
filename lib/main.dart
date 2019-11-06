
import 'package:darkness_dungeon/HealthBar.dart';
import 'package:darkness_dungeon/Joystick.dart';
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
    return Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            game.widget,
            Align(
              alignment: Alignment.topLeft,
              child: HealthBar(
                key: healthKey
              ),
            ),
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
  final Function(double) recieveDamage;
  Player player;
  MapWord map;
  bool playerIsRun = false;

  DarknessDungeon(this.size, {this.recieveDamage}){

    player = Knight.mainPlayer(
        size,
        initX: size.width/5 - Knight.sizePlayer,
        initY: size.height/3 - Knight.sizePlayer,
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

  @override
  void render(Canvas canvas) {
    map.render(canvas);
  }

  @override
  void update(double t) {
    map.update(t);
  }
}
