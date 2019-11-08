import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Player extends AnimationGameObject {

  double life;
  MapGame map;
  final Size screenSize;
  final double speedPlayer;
  final Function(double) changeLife;
  final Function callBackdie;
  final FlameAnimation.Animation animationIdle;
  final FlameAnimation.Animation animationMoveLeft;
  final FlameAnimation.Animation animationMoveRight;
  final FlameAnimation.Animation animationMoveTop;
  final FlameAnimation.Animation animationMoveBottom;
  final FlameAnimation.Animation animationDie;

  Player(
      this.screenSize,
      Rect position,
      this.animationIdle,
      {
        this.life = 1,
        this.speedPlayer = 1.8,
        this.animationMoveLeft,
        this.animationMoveRight,
        this.animationMoveTop,
        this.animationMoveBottom,
        this.animationDie,
        this.changeLife,
        this.callBackdie,
      }
      ){
    this.position = position;
    animation = animationIdle;
  }

  void moveToTop() {

    if (life == 0) {
      return;
    }

    if (position.top <= 0) {
      return;
    }
    Rect displacement = position.translate(0, (speedPlayer * -1));
    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.top > screenSize.height / 3 || map.isMaxTop()) {
      position = displacement;
    } else {
      map.moveTop(speedPlayer);
    }

    if(animationMoveTop != null){
      animation = animationMoveTop;
    }
  }

  void moveToBottom() {

    if (life == 0) {
      return;
    }

    if (position.bottom >= screenSize.height) {
      return;
    }
    Rect displacement = position.translate(0, speedPlayer);
    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.top < screenSize.height / 2 || map.isMaxBottom()) {
      position = displacement;
    } else {
      map.moveBottom(speedPlayer);
    }

    if(animationMoveBottom != null){
      animation = animationMoveBottom;
    }
  }

  void moveToLeft() {

    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }
    Rect displacement = position.translate((speedPlayer * -1), 0);
    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.left > screenSize.width / 3 || map.isMaxLeft()) {
      position = displacement;
    } else {
      map.moveLeft(speedPlayer);
    }

    if(animationMoveLeft != null){
      animation = animationMoveLeft;
    }
  }

  void moveToRight() {

    if (life == 0) {
      return;
    }

    if (position.right >= screenSize.width) {
      return;
    }

    Rect displacement = position.translate(speedPlayer, 0);
    if (map.verifyCollision(displacement)) {
      return;
    }
    if (position.left < screenSize.width / 2 || map.isMaxRight()) {
      position = displacement;
    } else {
      map.moveRight(speedPlayer);
    }

    if(animationMoveRight != null){
      animation = animationMoveRight;
    }
  }

  void runTopRight(){
    if (life == 0) {
      return;
    }

    if (position.left >= screenSize.width) {
      return;
    }

    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate(speedPlayer,(-1 *speedPlayer));

    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.left < screenSize.width / 2 || map.isMaxRight() || map.isMaxTop()) {
      position = displacement;
    } else {
      map.moveRight(speedPlayer);
      map.moveTop(speedPlayer);
    }

    if(animationMoveRight != null){
      animation = animationMoveRight;
    }
  }

  void runTopLeft(){
    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }

    if (position.top <= 0) {
      return;
    }

    Rect displacement = position.translate((-1 *speedPlayer), (-1 *speedPlayer));

    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.left > screenSize.width / 2 || map.isMaxLeft() || map.isMaxTop()) {
      position = displacement;
    } else {
      map.moveLeft(speedPlayer);
      map.moveTop(speedPlayer);
    }

    if(animationMoveLeft != null){
      animation = animationMoveLeft;
    }
  }

  void runBottomLeft(){
    //print('runBottomLeft');
    if (life == 0) {
      return;
    }

    if (position.left <= 0) {
      return;
    }
    if (position.bottom >= screenSize.height) {
      return;
    }

    Rect displacement = position.translate((-1 *speedPlayer), speedPlayer);

    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.left > screenSize.width / 2 || map.isMaxLeft() || map.isMaxBottom()) {
      position = displacement;
    } else {
      map.moveLeft(speedPlayer);
      map.moveBottom(speedPlayer);
    }

    if(animationMoveLeft != null){
      animation = animationMoveLeft;
    }
  }

  void runBottomRight(){
    //print('runBottomRight');
    if (life == 0) {
      return;
    }

    if (position.left >= screenSize.width) {
      return;
    }

    if (position.top >= screenSize.height) {
      return;
    }

    Rect displacement = position.translate(speedPlayer, speedPlayer);

    if (map.verifyCollision(displacement)) {
      return;
    }

    if (position.left < screenSize.width / 2 || map.isMaxRight() || map.isMaxBottom()) {
      position = displacement;
    } else {
      map.moveRight(speedPlayer);
      map.moveBottom(speedPlayer);
    }

    if(animationMoveRight != null){
      animation = animationMoveRight;
    }
  }

  void idle(){
    if (life == 0) {
      return;
    }
    animation = animationIdle;
  }

  void recieveAtack(double damage){
    life = life - damage;
    if (changeLife != null) {
      changeLife(life);
    }
    if (life < 0) {
      life = 0;
    }
    if (life == 0) {
      die();
    }
  }

  void die() {
    if (callBackdie != null) {
      callBackdie();
    }
    animation = FlameAnimation.Animation.sequenced("crypt.png", 1,
        textureWidth: 16, textureHeight: 16);
  }
}