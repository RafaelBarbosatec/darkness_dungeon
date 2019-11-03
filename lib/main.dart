import 'dart:math';

import 'package:darkness_dungeon/Joystick.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/map/MyMaps.dart';
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

  DarknessDungeon(this.size){
    player = AnimationGameObject()
        ..position = Rect.fromLTWH(size.width/5 - sizePlayer, size.height/3 -sizePlayer, sizePlayer, sizePlayer*1.4)
        ..animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);

    map = MyMaps.mainMap(size);

  }

  void idle(){
    playerIsRun = false;
    player.animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
  }

  void runTop(){

    if(player.position.top <= 0){
      return;
    }
    Rect displacement = player.position.translate(0, (speedPlayer * -1));
    if(map.verifyCollisions(displacement)){
      return;
    }

    if(player.position.top > size.height/3 || map.isMaxTop()) {
      player.position = displacement;
    }else{
      map.moveTop();
    }
    _runPlayerAniamation();

  }

  void runBottom(){
    if(player.position.bottom >= size.height){
      return;
    }
    Rect displacement = player.position.translate(0, speedPlayer);
    if(map.verifyCollisions(displacement)){
      return;
    }

    if(player.position.top < size.height/2 || map.isMaxBottom()) {
      player.position = displacement;
    }else{
      map.moveBottom();
    }
    _runPlayerAniamation();

  }

  void runLeft(){
    if(player.position.left <= 0){
      return;
    }
    Rect displacement = player.position.translate((speedPlayer * -1), 0);
    if(map.verifyCollisions(displacement)){
      return;
    }

    if(player.position.left > size.width/3 || map.isMaxLeft()) {
      player.position = displacement;
    }else{
      map.moveLeft();
    }
    _runPlayerAniamation(left: true);
  }

  void runRight(){
    if(player.position.right >= size.width){
      return;
    }
    Rect displacement = player.position.translate(speedPlayer, 0);
    if(map.verifyCollisions(displacement)){
      return;
    }
    if(player.position.left < size.width/2 || map.isMaxRight()) {
      player.position = displacement;
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
    map.update(t);
    player.update(t);
  }
}
