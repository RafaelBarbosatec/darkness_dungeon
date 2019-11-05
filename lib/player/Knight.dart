
import 'package:darkness_dungeon/player/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Knight extends Player{

  static const double speedPlayer = 10;
  static const double sizePlayer = 25;
  final Size screenSize;
  final Function die;
  final Function(double) changeLife;
  bool playerIsRun = false;

  Knight(this.screenSize, {this.die,this.changeLife}){
    life = 100;
  }

  factory Knight.mainPlayer(Size screenSize, {double initX = 0.0, double initY = 0.0, Function(double) changeLife}){
    return Knight(screenSize,changeLife: changeLife)
      ..position = Rect.fromLTWH(initX - sizePlayer, initY -sizePlayer, sizePlayer, sizePlayer)
      ..animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
  }

  void moveToTop(){

    if(life == 0){
      return;
    }

    if(position.top <= 0){
      return;
    }
    Rect displacement = position.translate(0, (speedPlayer * -1));
    if(map.verifyCollision(displacement)){
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

    if(life == 0){
      return;
    }

    if(position.bottom >= screenSize.height){
      return;
    }
    Rect displacement = position.translate(0, speedPlayer);
    if(map.verifyCollision(displacement)){
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

    if(life == 0){
      return;
    }

    if(position.left <= 0){
      return;
    }
    Rect displacement = position.translate((speedPlayer * -1), 0);
    if(map.verifyCollision(displacement)){
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

    if(life == 0){
      return;
    }

    if(position.right >= screenSize.width){
      return;
    }
    Rect displacement = position.translate(speedPlayer, 0);
    if(map.verifyCollision(displacement)){
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

    if(life == 0){
      return;
    }

    playerIsRun = false;
    animation = FlameAnimation.Animation.sequenced("knight_idle.png", 6, textureWidth: 16, textureHeight: 16);
    super.idle();
  }

  @override
  void recieveAtack(double damage) {
    life = life - damage;
    if(changeLife != null){
      changeLife(life);
    }
    if(life< 0){
      life = 0;
    }
    if(life == 0){
      _die();
    }
    super.recieveAtack(damage);
  }

  void _runPlayerAniamation({bool left = false}){
    if(!playerIsRun){
      playerIsRun = true;
      animation = FlameAnimation.Animation.sequenced(left ? "knight_run_left.png":"knight_run.png", 6, textureWidth: 16, textureHeight: 16);
    }
  }

  void _die() {
    if(die != null){
      die();
    }
    animation = FlameAnimation.Animation.sequenced("crypt.png", 1, textureWidth: 16, textureHeight: 16);
  }
}