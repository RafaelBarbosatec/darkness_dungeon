import 'dart:async';
import 'dart:math';
import 'package:darkness_dungeon/core/Decoration.dart';
import 'package:darkness_dungeon/core/Direction.dart';
import 'package:darkness_dungeon/core/Enemy.dart';
import 'package:darkness_dungeon/core/ObjectCollision.dart';
import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Player extends AnimationGameObject with ObjectCollision {

  double life;
  MapControll _mapControll;
  double stamina = 100;
  double costStamina = 15;
  final double size;
  final double damageAtack;
  final Size screenSize;
  final double speedPlayer;
  final Function(double) changeLife;
  final Function(double) changeStamina;
  final Function callBackdie;
  final FlameAnimation.Animation animationIdle;
  final FlameAnimation.Animation animationIdleLeft;
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
  Direction lasDirection = Direction.right;
  Direction lasDirectionHotizontal = Direction.right;
  Timer _timerStamina;
  bool notifyDie = false;
  Rect initPosition;
  List<Enemy> _enemies = List();

  Player(
      this.size,
      this.screenSize,
      Rect position,
      this.animationIdle,
      {
        this.damageAtack = 1,
        this.life = 1,
        this.speedPlayer = 1,
        this.animationIdleLeft,
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
        this.changeStamina,
        this.callBackdie,
      }
      ){
    initPosition = position;
    this.position = position;
    animation = animationIdle;
    rectCollision = getRectCollision();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(life > 0) {
      atackObject.render(canvas);
    }
  }

  void setMapControll(MapControll mapControll){
    _mapControll = mapControll;
  }

  void updatePlayer(double dt, List<Rect> collisionsMap, List<Enemy> enemies, List<TileDecoration> decorations) {
    super.update(dt);
    this.collisionsMap = collisionsMap;
    this.rectCollision = getRectCollision();
    this._enemies = enemies;
    _updateAtackObject(dt);
  }

  void moveToTop() {

    if (life == 0) {
      return;
    }

    if (position.top <= 0) {
      return;
    }
    Rect displacement = position.translate(0, (speedPlayer * -1));

    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.top > screenSize.height / 3 || _mapControll.isMaxTop()) {
      position = displacement;
    } else {
      _mapControll.moveTop(speedPlayer);
    }

    lasDirection = Direction.top;

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
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.top < screenSize.height / 1.5 || _mapControll.isMaxBottom()) {
      position = displacement;
    } else {
      _mapControll.moveBottom(speedPlayer);
    }

    lasDirection = Direction.bottom;

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
    if (verifyCollisionRect(displacement)) {
      return;
    }

    if (position.left > screenSize.width / 3 || _mapControll.isMaxLeft()) {
      position = displacement;
    } else {
      _mapControll.moveLeft(speedPlayer);
    }

    lasDirection = Direction.left;
    lasDirectionHotizontal = Direction.left;

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
    if (verifyCollisionRect(displacement)) {
      return;
    }
    if (position.left < screenSize.width / 1.5 || _mapControll.isMaxRight()) {
      position = displacement;
    } else {
      _mapControll.moveRight(speedPlayer);
    }

    lasDirection = Direction.right;
    lasDirectionHotizontal = Direction.right;

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

    Rect displacementRight = position.translate(speedPlayer,0);

    if (!verifyCollisionRect(displacementRight)) {

      if (position.left < screenSize.width / 1.5 || _mapControll.isMaxRight()) {
        position = displacementRight;
      } else {
        _mapControll.moveRight(speedPlayer);
      }

      if(animationMoveRight != null){
        animation = animationMoveRight;
      }

    }

    Rect displacementTop = position.translate(0,(-1 *speedPlayer));

    if (!verifyCollisionRect(displacementTop)) {

      if (position.top > screenSize.height / 3 || _mapControll.isMaxTop()) {
        position = displacementTop;
      } else {
        _mapControll.moveTop(speedPlayer);
      }

      if(animationMoveRight != null){
        animation = animationMoveRight;
      }
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

    Rect displacementLeft = position.translate((-1 *speedPlayer), 0);

    if (!verifyCollisionRect(displacementLeft)) {
      if (position.left > screenSize.width / 1.5
          || _mapControll.isMaxLeft()) {
        position = displacementLeft;
      } else {
        _mapControll.moveLeft(speedPlayer);
      }
      if(animationMoveLeft != null){
        animation = animationMoveLeft;
      }
    }

    Rect displacementTop = position.translate(0, (-1 *speedPlayer));

    if (!verifyCollisionRect(displacementTop)) {
      if (position.top > screenSize.height / 3 || _mapControll.isMaxTop()) {
        position = displacementTop;
      } else {
        _mapControll.moveTop(speedPlayer);
      }

      if(animationMoveLeft != null){
        animation = animationMoveLeft;
      }
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

    Rect displacementLeft = position.translate((-1 *speedPlayer), 0);

    if (!verifyCollisionRect(displacementLeft)) {

      if (position.left > screenSize.width / 1.5 || _mapControll.isMaxLeft()) {
        position = displacementLeft;
      } else {
        _mapControll.moveLeft(speedPlayer);
      }

      if(animationMoveLeft != null){
        animation = animationMoveLeft;
      }
    }

    Rect displacementBottom = position.translate(0, speedPlayer);

    if (!verifyCollisionRect(displacementBottom)) {
      if (position.top < screenSize.height / 1.5 || _mapControll.isMaxBottom()) {
        position = displacementBottom;
      } else {
        _mapControll.moveBottom(speedPlayer);
      }

      if(animationMoveLeft != null){
        animation = animationMoveLeft;
      }
    }

  }

  void runBottomRight(){

    if (life == 0) {
      return;
    }

    if (position.left >= screenSize.width) {
      return;
    }

    if (position.top >= screenSize.height) {
      return;
    }

    Rect displacementRight = position.translate(speedPlayer, 0);

    if (!verifyCollisionRect(displacementRight)) {

      if (position.left < screenSize.width / 1.5
          || _mapControll.isMaxRight()) {
        position = displacementRight;
      } else {
        _mapControll.moveRight(speedPlayer);
      }

      if(animationMoveRight != null){
        animation = animationMoveRight;
      }
    }

    Rect displacementBottom = position.translate(0, speedPlayer);

    if (!verifyCollisionRect(displacementBottom)) {

      if (position.top < screenSize.height / 1.5 || _mapControll.isMaxBottom()) {
        position = displacementBottom;
      } else {
        _mapControll.moveBottom(speedPlayer);
      }

      if(animationMoveRight != null){
        animation = animationMoveRight;
      }
    }

  }

  void idle(){
    if (life == 0) {
      return;
    }

    if(lasDirectionHotizontal == Direction.right) {
      animation = animationIdle;
    }else{
      animation = animationIdleLeft;
    }
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
    if (callBackdie != null && !notifyDie) {
      notifyDie = true;
      callBackdie();
    }
    animation = FlameAnimation.Animation.sequenced("crypt.png", 1,
        textureWidth: 16, textureHeight: 16);
  }

  void atack() {

    if(life <= 0){
      return;
    }

    startTimeStamina();

    if(stamina < costStamina){
      return;
    }

    stamina = stamina - costStamina;

    if(changeStamina != null){
      changeStamina(stamina);
    }

    switch(lasDirection){
      case Direction.top: atackObject.animation = animationAtackTop; break;
      case Direction.bottom: atackObject.animation = animationAtackBottom; break;
      case Direction.left: atackObject.animation = animationAtackLeft; break;
      case Direction.right: atackObject.animation = animationAtackRight; break;
    }

    atackObject.animation.clock = 0;
    atackObject.animation.currentIndex = 0;
    atackObject.animation.loop = true;


    double damageMin = damageAtack /2;
    int p = Random().nextInt(damageAtack.toInt() + (damageMin.toInt()));
    double damage = damageMin + p;

    List<Enemy> enemyLife = _enemies.where((e)=>!e.isDie()).toList();
    enemyLife.forEach((enemy){
      if(atackObject.position.overlaps(enemy.getCurrentPosition())){
        enemy.receiveDamage(damage,lasDirection);
      }
    });

  }

  void startTimeStamina() {
    if(_timerStamina != null && _timerStamina.isActive){
      return;
    }
    _timerStamina = Timer.periodic(new Duration(milliseconds: 150), (timer) {
      if(life == 0){
        return;
      }

      stamina = stamina +1.5;
      if(stamina > 100){
        stamina = 100;
      }
      changeStamina(stamina);
    });
  }

  void reset(double x, double y){

    notifyDie = false;
    this.animation = animationIdle;
    this.position = initPosition;
    stamina = 100;
    life = 100;
  }

  Rect getRectCollision() {
    return Rect.fromLTWH(position.left, position.top + (position.height / 2), position.width / 1.5, position.height / 3);
  }

  void _updateAtackObject(double dt) {
    double top = position.top;
    double left = position.left;
    switch(lasDirection){
      case Direction.top: top = top-size; break;
      case Direction.bottom: top = top+size; break;
      case Direction.left: left = left-size; break;
      case Direction.right: left = left+size; break;
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

}