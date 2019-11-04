
import 'package:darkness_dungeon/player/Player.dart';
import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Knight extends Player{

  static const double speedPlayer = 10;
  static const double sizePlayer = 25;
  final MapGame map;
  final Size screenSize;
  bool playerIsRun = false;

  Knight(this.map, this.screenSize);

  factory Knight.mainPlayer(MapGame map, Size screenSize, {double initX = 0.0, double initY = 0.0}){
    return Knight(map,screenSize)
      ..position = Rect.fromLTWH(initX - sizePlayer, initY -sizePlayer, sizePlayer, sizePlayer*1.4)
      ..animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
  }

  void moveToTop(){
    if(position.top <= 0){
      return;
    }
    Rect displacement = position.translate(0, (speedPlayer * -1));
    if(map.verifyCollisionsPlayer(displacement)){
      return;
    }

    if(position.top > screenSize.height/3 || map.isMaxTop()) {
      position = displacement;
    }else{
      map.moveTop();
    }
    _runPlayerAniamation();
  }

  void moveToBottom(){
    if(position.bottom >= screenSize.height){
      return;
    }
    Rect displacement = position.translate(0, speedPlayer);
    if(map.verifyCollisionsPlayer(displacement)){
      return;
    }

    if(position.top < screenSize.height/2 || map.isMaxBottom()) {
      position = displacement;
    }else{
      map.moveBottom();
    }
    _runPlayerAniamation();
  }

  void moveToLeft(){
    if(position.left <= 0){
      return;
    }
    Rect displacement = position.translate((speedPlayer * -1), 0);
    if(map.verifyCollisionsPlayer(displacement)){
      return;
    }

    if(position.left > screenSize.width/3 || map.isMaxLeft()) {
      position = displacement;
    }else{
      map.moveLeft();
    }
    _runPlayerAniamation(left: true);
  }

  void moveToRight(){
    if(position.right >= screenSize.width){
      return;
    }
    Rect displacement = position.translate(speedPlayer, 0);
    if(map.verifyCollisionsPlayer(displacement)){
      return;
    }
    if(position.left < screenSize.width/2 || map.isMaxRight()) {
      position = displacement;
    }else{
      map.moveRight();
    }
    _runPlayerAniamation();

  }

  @override
  void idle() {
    playerIsRun = false;
    animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
    super.idle();
  }

  void _runPlayerAniamation({bool left = false}){
    if(!playerIsRun){
      playerIsRun = true;
      animation = FlameAnimation.Animation.sequenced(left ? "knight_run_left.png":"knight_run.png", 6, textureWidth: 16, textureHeight: 16);
    }
  }
}