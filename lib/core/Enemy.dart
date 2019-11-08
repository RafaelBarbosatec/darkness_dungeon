
import 'dart:async';

import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

abstract class Enemy extends AnimationGameObject{

  final double life;
  final double speed;
  //millesegundos
  final int intervalAtack;
  final double visionCells;
  final double size;
  final FlameAnimation.Animation animationIdle;
  final FlameAnimation.Animation animationMoveLeft;
  final FlameAnimation.Animation animationMoveRight;
  final FlameAnimation.Animation animationMoveTop;
  final FlameAnimation.Animation animationMoveBottom;

  MapGame _map;
  Rect _currentPosition;
  bool _isSetPosition = false;
  bool _closePlayer = false;
  bool _isIdle = true;
  Timer _timer;
  Timer _timerMove;
  Rect _moveTo;
  bool _blockCollision = false;

  Enemy(
      Rect position,
      this.animationIdle,
      {
        this.size = 16,
        this.life = 1,
        this.speed = 25,
        this.intervalAtack = 500,
        this.visionCells = 4,
        this.animationMoveLeft,
        this.animationMoveRight,
        this.animationMoveTop,
        this.animationMoveBottom,
      }
      ){
    animation = animationIdle;
    this.position = position;
  }

  setInitPosition(Rect position){
    if(!_isSetPosition){
      _isSetPosition = true;
      this.position = position;
    }
  }

  void setMap(MapGame m){
    _map = m;
  }

  void updateEnemy(
      double t,
      Rect player
      ){
    super.update(t);
  }

  void moveToHero(Rect player, Function() attack){

    if(player != null && position != null){

      //CALCULA POSIÇÃO ATUAL DO INIMIGO LEVANDO EM BASE A POSIÇÃO DA CAMARA
      _currentPosition = Rect.fromLTWH(
          position.left + (_map != null ? _map.paddingLeft : 0),
          position.top + (_map != null ? _map.paddingTop : 0),
          position.width,
          position.height
      );

      // CRIA COMPO DE VISÃO DO INIMIGO
      double visionWidth = _currentPosition.width * visionCells*2;
      double visionHeight = _currentPosition.height * visionCells*2;
      Rect fieldOfVision = Rect.fromLTWH(_currentPosition.left - (visionWidth/2), _currentPosition.top - (visionHeight/2), visionWidth, visionHeight);

      //CALCULA CENTRO DO PLAYER
      double leftPlayer = player.left + player.width/2;
      double topPlayer = player.top + player.height/2;

      if(fieldOfVision.overlaps(player)){

        double translateX = _currentPosition.left > leftPlayer ? -1:1;
        double translateY = _currentPosition.top > topPlayer? -1:1;

        if(_currentPosition.left == leftPlayer){
          translateX = 0;
        }
        if(_currentPosition.top == topPlayer){
          translateY = 0;
        }

        if(translateX > 0){
          animToRight();
        }else if(translateX < 0){
          animToLeft();
        }else if(translateY > 0){
          animToBottom();
        }else if(translateY < 0){
          animToTop();
        }else{
          if(!_isIdle) {
            animation = animationIdle;
          }
        }

        _moveTo = position.translate(translateX, translateY);

        if(_occurredCollision(leftPlayer, topPlayer)){
          animation = animationIdle;
          _blockCollision = true;
          return;
        }

        _blockCollision = false;

        if(_arrivedNext(player)){
          if(!_closePlayer){
            attack();
          }
          _closePlayer = true;
          _verifyAtack(attack);
          return;
        }else{
          if(_closePlayer){
            notSee();
          }
        }

        _startTimeMove();

      }else{

        _stopTimeMove();
        if(_closePlayer){
          notSee();
        }

      }

    }

  }

  bool _arrivedNext(Rect player) {
    return _currentPosition.overlaps(player);
  }

  bool _occurredCollision(double leftPlayer,double topPlayer){
    var left = (_map != null ? _map.paddingLeft : 0);
    var top = (_map != null ? _map.paddingTop : 0);
    double displacementCollision = size/2;
    double translateXToCollision = _currentPosition.left > leftPlayer ? (displacementCollision *-1):displacementCollision;
    double translateYToCollision = _currentPosition.top > topPlayer? (displacementCollision *-1):displacementCollision;
    var moveToCurrent = position.translate(translateXToCollision + left , translateYToCollision + top);
    if(_map == null){
      return false;
    }
    return _map.verifyCollision(moveToCurrent);
  }

  void _verifyAtack(Function() attack) {
    if(_timer != null && _timer.isActive){
      return;
    }
    _timer = Timer.periodic(new Duration(milliseconds: intervalAtack), (timer) {
      if(_closePlayer){
        attack();
      }
    });
  }

  void notSee() {
    _closePlayer = false;
    if(_timer != null){
      _timer.cancel();
      _timer = null;
    }
    animation = animationIdle;
  }

  void atackPlayer(double damage){
    _map.atackPlayer(damage);
  }

  void animToRight() {
    if(animationMoveRight != null){
      _isIdle = false;
      animation = animationMoveRight;
    }
  }

  void animToLeft() {
    if(animationMoveLeft != null){
      _isIdle = false;
      animation = animationMoveLeft;
    }
  }

  void animToTop() {
    if(animationMoveTop != null){
      _isIdle = false;
      animation = animationMoveTop;
    }
  }
  void animToBottom() {
    if(animationMoveBottom != null){
      _isIdle = false;
      animation = animationMoveBottom;
    }
  }

  void _startTimeMove() {
    if(_timerMove != null && _timerMove.isActive){
      return;
    }
    _timerMove = Timer.periodic(new Duration(milliseconds: 1000~/speed), (timer) {
      if(!_blockCollision)
        position = _moveTo;
    });

  }

  void _stopTimeMove() {
    if(_timerMove != null){
      _timerMove.cancel();
      _timerMove = null;
    }
  }

}