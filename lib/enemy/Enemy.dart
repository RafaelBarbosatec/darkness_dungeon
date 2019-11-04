
import 'package:darkness_dungeon/map/TileMap.dart';
import 'package:darkness_dungeon/util/AnimationGameObject.dart';
import 'package:flutter/material.dart';
abstract class Enemy extends AnimationGameObject{

  Rect currentPosition;

  bool isSetPosition = false;

  double speed = 0.8;

  double visionCells = 4;

  setInitPosition(Rect position){
    if(!isSetPosition){
      isSetPosition = true;
      this.position = position;
    }
  }

  void updateEnemy(
      double t,
      Rect player,
      List<TileMap> collisions,
      double paddingLeft,
      double paddingTop
      ){
    super.update(t);
  }

  void moveToHero(Rect player,
      List<TileMap> collisions,
      double paddingLeft,
      double paddingTop, Function() attack){

    if(player != null){
      currentPosition = Rect.fromLTWH(
          position.left + paddingLeft,
          position.top + paddingTop,
          position.width,
          position.height
      );

      double visionWidth = currentPosition.width * visionCells*2;
      double visionHeight = currentPosition.height * visionCells*2;

      Rect fieldOfVision = Rect.fromLTWH(currentPosition.left - (visionWidth/2), currentPosition.top - (visionHeight/2), visionWidth, visionHeight);

      double left = player.left + player.width/2;
      double top = player.top + player.height/2;
      if(fieldOfVision.overlaps(player)){
        double translateX = currentPosition.left > left ? (speed *-1):speed;
        double translateY = currentPosition.top > top? (speed *-1):speed;

        if(currentPosition.left == left){
          translateX = 0;
        }
        if(currentPosition.top == top){
          translateY = 0;
        }
        var moveTo = position.translate(translateX, translateY);

        if(_arrivedNext(player)){
          attack();
          return;
        }
        position = moveTo;
      }
    }

  }

  bool _arrivedNext(Rect player) {
    return currentPosition.overlaps(player);
  }

}