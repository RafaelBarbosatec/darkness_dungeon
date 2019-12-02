
import 'dart:math';

double randomic(double max){
  double damageMin = max /2;
  int p = Random().nextInt(max.toInt() + (damageMin.toInt()));
  return damageMin + p;
}