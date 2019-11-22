
import 'package:flutter/material.dart';

class ObjectCollision{
  List<Rect> collisionsMap = List();
  Rect rectCollision;

  bool verifyCollision() {
    if(rectCollision == null){
      return false;
    }
    var itensCollision = collisionsMap.where((i) => i.overlaps(rectCollision)).toList();
    return itensCollision.length > 0;
  }

  bool verifyCollisionRect(Rect rect) {
    var itensCollision = collisionsMap.where((i) => i.overlaps(rect)).toList();
    return itensCollision.length > 0;
  }
}