
import 'package:flutter/material.dart';

class ObjectCollision{
  List<Rect> collisionsMap = List();
  Rect rectCollision;
  double heightCollision = 0;
  double widthCollision = 0;

  bool verifyCollision() {
    if(rectCollision == null){
      return false;
    }
    Rect newRectCollision = Rect.fromLTWH(
        rectCollision.left + (rectCollision.width - widthCollision) /2,
        rectCollision.top + heightCollision,
        widthCollision,
        heightCollision
    );
    var itensCollision = collisionsMap.where((i) => i.overlaps(newRectCollision)).toList();
    return itensCollision.length > 0;
  }

  bool verifyCollisionRect(Rect rect) {
    Rect rectCollision = Rect.fromLTWH(
        rect.left + (rect.width - widthCollision) /2,
        rect.top + heightCollision,
        widthCollision,
        heightCollision
    );
    var itensCollision = collisionsMap.where((i) => i.overlaps(rectCollision)).toList();
    return itensCollision.length > 0;
  }
}