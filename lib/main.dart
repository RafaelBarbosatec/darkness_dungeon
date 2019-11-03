import 'dart:math';

import 'package:darkness_dungeon/Joystick.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/map/TileMap.dart';
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

class AnimationGameObject {
  Rect position;
  FlameAnimation.Animation animation;

  void render(Canvas canvas) {
    if (animation.loaded()) {
      animation.getSprite().renderRect(canvas, position);
    }
  }

  void update(double dt) {
    animation.update(dt);
  }
}

class DarknessDungeon extends Game {
  final Size size;
  AnimationGameObject player;
  MapWord map;
  bool playerIsRun = false;
  final double speedPlayer = 10;
  final double sizePlayer = 30;

  Random random = Random();

  DarknessDungeon(this.size){
    player = AnimationGameObject()
        ..position = Rect.fromLTWH(size.width/2 - sizePlayer, size.height/2 -sizePlayer, sizePlayer, sizePlayer*1.4)
        ..animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);

    map = MapWord(
        List.generate((size.height*2)~/16, (index){
          return List.generate((size.width*2)~/16, (index){
            int p = random.nextInt(3);
            String sprite = "";
            switch(p){
              case 0: sprite = 'tile/floor_1.png'; break;
              case 1: sprite = 'tile/floor_2.png'; break;
              case 2: sprite = 'tile/floor_3.png'; break;
            }
            return TileMap(sprite);
          });
        }),
        size
    );
  }

  void idle(){
    playerIsRun = false;
    player.animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
  }

  void runTop(){
    if(player.position.top <= 0){
      return;
    }
    if(player.position.top > size.height/3 || map.isMaxTop()) {
      player.position = player.position.translate(0, (speedPlayer * -1));
    }else{
      map.moveTop();
    }
    _runPlayerAniamation();

  }

  void runBottom(){
    if(player.position.bottom >= size.height){
      return;
    }
    if(player.position.top < size.height/2 || map.isMaxBottom()) {
      player.position = player.position.translate(0, speedPlayer);
    }else{
      map.moveBottom();
    }
    _runPlayerAniamation();

  }

  void runLeft(){
    if(player.position.left <= 0){
      return;
    }
    if(player.position.left > size.width/3 || map.isMaxLeft()) {
      player.position = player.position.translate((speedPlayer * -1), 0);
    }else{
      map.moveLeft();
    }
    _runPlayerAniamation(left: true);
  }

  void runRight(){
    if(player.position.right >= size.width){
      return;
    }
    if(player.position.left < size.width/2 || map.isMaxRight()) {
      player.position = player.position.translate(speedPlayer, 0);
    }else{
      map.moveRight();
    }
    _runPlayerAniamation();

  }

  void _runPlayerAniamation({bool left = false}){
    if(!playerIsRun){
      playerIsRun = true;
      player.animation = FlameAnimation.Animation.sequenced(left ? "knight_run_left.png":"knight_run.png", 6, textureWidth: 16, textureHeight: 16);
    }
  }

  @override
  void render(Canvas canvas) {
    map.render(canvas);
    player.render(canvas);
  }

  @override
  void update(double t) {
    player.update(t);
  }
}
