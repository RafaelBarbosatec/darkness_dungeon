
import 'dart:async';

import 'package:darkness_dungeon/map/MapWord.dart';
import 'package:darkness_dungeon/util/AnimationGameObject.dart';
import 'package:flutter/material.dart';

abstract class Enemy extends AnimationGameObject{

  double life = 1;
  MapGame map;
  Rect currentPosition;
  bool isSetPosition = false;
  double speed = 0.8;

  //millesegundos
  int speedAtack = 500;
  double visionCells = 4;
  double size = 16;
  bool closePlayer = false;
  Timer _timer;

  setInitPosition(Rect position){
    if(!isSetPosition){
      isSetPosition = true;
      this.position = position;
    }
  }

  void updateEnemy(
      double t,
      Rect player
      ){
    super.update(t);
  }

  void moveToHero(Rect player, Function() attack){

    if(player != null){

      //CALCULA POSIÇÃO ATUAL DO INIMIGO LEVANDO EM BASE A POSIÇÃO DA CAMARA
      currentPosition = Rect.fromLTWH(
          position.left + map.paddingLeft,
          position.top + map.paddingTop,
          position.width,
          position.height
      );

      // CRIA COMPO DE VISÃO DO INIMIGO
      double visionWidth = currentPosition.width * visionCells*2;
      double visionHeight = currentPosition.height * visionCells*2;
      Rect fieldOfVision = Rect.fromLTWH(currentPosition.left - (visionWidth/2), currentPosition.top - (visionHeight/2), visionWidth, visionHeight);

      //CALCULA CENTRO DO PLAYER
      double leftPlayer = player.left + player.width/2;
      double topPlayer = player.top + player.height/2;

      if(fieldOfVision.overlaps(player)){

        double translateX = currentPosition.left > leftPlayer ? (speed *-1):speed;
        double translateY = currentPosition.top > topPlayer? (speed *-1):speed;

        if(currentPosition.left == leftPlayer){
          translateX = 0;
        }
        if(currentPosition.top == topPlayer){
          translateY = 0;
        }

        var moveTo = position.translate(translateX, translateY);

        if(_occurredCollision(leftPlayer, topPlayer)){
          return;
        }

        if(_arrivedNext(player)){
          closePlayer = true;
          _verifyAtack(attack);
          return;
        }else{
          if(closePlayer){
            closePlayer = false;
          }
        }

        position = moveTo;

      }else{

        if(closePlayer){
          closePlayer = false;
        }

      }

    }

  }

  bool _arrivedNext(Rect player) {
    return currentPosition.overlaps(player);
  }

  bool _occurredCollision(double leftPlayer,double topPlayer){
    double displacementCollision = size/2;
    double translateXToCollision = currentPosition.left > leftPlayer ? (displacementCollision *-1):displacementCollision;
    double translateYToCollision = currentPosition.top > topPlayer? (displacementCollision *-1):displacementCollision;
    var moveToCurrent = position.translate(translateXToCollision + map.paddingLeft , translateYToCollision + map.paddingTop);
    return map.verifyCollision(moveToCurrent);
  }

  void _verifyAtack(Function() attack) {
    if(_timer != null && _timer.isActive){
      return;
    }
    _timer = Timer.periodic(new Duration(milliseconds: speedAtack), (timer) {
      if(closePlayer){
        attack();
      }
    });
  }

}