import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Player extends AnimationGameObject {

  double life;
  MapGame map;
  final double size;
  final double damageAtack;
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
  final FlameAnimation.Animation animationAtackLeft;
  final FlameAnimation.Animation animationAtackRight;
  final FlameAnimation.Animation animationAtackTop;
  final FlameAnimation.Animation animationAtackBottom;
  AnimationGameObject atackObject = AnimationGameObject();
  String lastOrientation = "RIGHT";

  Player(
      this.size,
      this.screenSize,
      Rect position,
      this.animationIdle,
      {
        this.damageAtack = 1,
        this.life = 1,
        this.speedPlayer = 1,
        this.animationMoveLeft,
        this.animationMoveRight,
        this.animationMoveTop,
        this.animationMoveBottom,
        this.animationDie,
        this.animationAtackLeft,
        this.animationAtackRight,
        this.animationAtackTop,
        this.animationAtackBottom,
        this.changeLife,
        this.callBackdie,
      }
      ){
    this.position = position;
    animation = animationIdle;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(life > 0) {
      atackObject.render(canvas);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    double top = position.top;
    double left = position.left;
    switch(lastOrientation){
      case "TOP": top = top-size; break;
      case "BOTTOM": top = top+size; break;
      case "LEFT": left = left-size; break;
      case "RIGHT": left = left+size; break;
    }

    if(position != null){
      atackObject.position = Rect.fromLTWH(
          left,
          top,
          size,
          size
      );
    }

    atackObject.update(dt);

    if(atackObject.animation != null){
      if(atackObject.animation.isLastFrame){
        atackObject.animation.loop = false;
      }
    }

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

    lastOrientation = "TOP";

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

    lastOrientation = "BOTTOM";

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

    lastOrientation = "LEFT";

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

    lastOrientation = "RIGHT";

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

  void atack() {

      switch(lastOrientation){
        case "TOP": atackObject.animation = animationAtackTop; break;
        case "BOTTOM": atackObject.animation = animationAtackBottom; break;
        case "LEFT": atackObject.animation = animationAtackLeft; break;
        case "RIGHT": atackObject.animation = animationAtackRight; break;
      }

      atackObject.animation.clock = 0;
      atackObject.animation.currentIndex = 0;
      atackObject.animation.loop = true;

      map.atackEnemy(atackObject.position, damageAtack);

  }
}