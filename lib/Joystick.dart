
import 'dart:async';

import 'package:flutter/material.dart';

class Joystick extends StatefulWidget {

  final GestureTapCallback tabTop;
  final GestureTapCallback tabLeft;
  final GestureTapCallback tabBottom;
  final GestureTapCallback tabRight;
  final GestureTapCallback idle;

  const Joystick({Key key, this.tabTop, this.tabLeft, this.tabBottom, this.tabRight, this.idle}) : super(key: key);

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {

  Color color = Colors.white.withAlpha(100);
  bool enableLoop = false;
  bool isTop = false;
  bool isLeft = false;
  bool isRight = false;
  bool isBottom= false;
  Timer timer;

  double sizeButton = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      height: 130,
      width: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTapDown: (_){
                isTop = true;
                startLoop();
              },
              onTapUp: (_){
                isTop = false;
                stopLoop();
              },
              onTapCancel: (){
                isTop = false;
                stopLoop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                height: sizeButton,
                width: sizeButton,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTapDown: (_){
                isRight = true;
                startLoop();
              },
              onTapUp: (_){
                isRight = false;
                stopLoop();
              },
              onTapCancel: (){
                isRight = false;
                stopLoop();
              },
              child: Container(
                height: sizeButton,
                width: sizeButton,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTapDown: (_){
                isLeft = true;
                startLoop();
              },
              onTapUp: (_){
                isLeft = false;
                stopLoop();
              },
              onTapCancel: (){
                isLeft = false;
                stopLoop();
              },
              child: Container(
                height: sizeButton,
                width: sizeButton,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTapDown: (_){
                isBottom = true;
                startLoop();
              },
              onTapUp: (_){
                isBottom = false;
                stopLoop();
              },
              onTapCancel: (){
                isBottom = false;
                stopLoop();
              },
              child: Container(
                height: sizeButton,
                width: sizeButton,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startLoop() {
    if(timer != null && timer.isActive){
      return;
    }
    timer = Timer.periodic(new Duration(milliseconds: 50), (timer) {
      if(isTop && widget.tabTop != null){
        widget.tabTop();
      }
      if(isBottom && widget.tabBottom != null){
        widget.tabBottom();
      }
      if(isLeft && widget.tabLeft != null){
        widget.tabLeft();
      }
      if(isRight && widget.tabRight != null){
        widget.tabRight();
      }
    });
  }

  void stopLoop() {
    if(!isTop && !isLeft && !isRight && !isBottom){
      timer.cancel();
      if(widget.idle!= null){
        widget.idle();
      }
    }
  }
}
