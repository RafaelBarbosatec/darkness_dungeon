import 'package:darkness_dungeon/core/map/MapWord.dart';
import 'package:darkness_dungeon/core/AnimationGameObject.dart';

class Player extends AnimationGameObject {

  double life;
  MapGame map;

  Player({this.life});

  void moveToTop() {}

  void moveToBottom() {}

  void moveToLeft() {}

  void moveToRight() {}

  void idle(){}

  void recieveAtack(double damage){}
}