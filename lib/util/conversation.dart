import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/material.dart';

class Conversation {
  static show(BuildContext context, List list) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConversationWidget();
      },
    );
  }
}

class ConversationWidget extends StatefulWidget {
  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  Timer timer;
  String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis pulvinar libero, sit amet finibus lectus porttitor at.";
  int countLetter = 1;

  StreamController<String> _streamController = StreamController<String>();

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _streamController.add(text.substring(0, countLetter));
      countLetter++;
      if (countLetter == text.length + 1) {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        timer.cancel();
        _streamController.add(text);
      },
      child: Container(
        color: Colors.transparent,
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flame.util.animationAsWidget(
                Position(80, 100),
                FlameAnimation.Animation.sequenced(
                  "npc/wizard_idle_left.png",
                  4,
                  textureWidth: 16,
                  textureHeight: 22,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder(
                      stream: _streamController.stream,
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            snapshot.hasData ? snapshot.data : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Normal',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
