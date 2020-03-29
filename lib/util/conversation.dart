import 'dart:async';

import 'package:darkness_dungeon/util/talk.dart';
import 'package:flutter/material.dart';

class Conversation {
  static show(BuildContext context, List<Talk> list) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConversationWidget(
          talks: list,
        );
      },
    );
  }
}

class ConversationWidget extends StatefulWidget {
  final List<Talk> talks;

  const ConversationWidget({Key key, this.talks}) : super(key: key);
  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  Timer timer;
  Talk currentTalk;
  int currentIndexTalk = 0;
  int countLetter = 1;
  bool finishCurrentTalk = false;

  StreamController<String> _textShowController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    currentTalk = widget.talks[currentIndexTalk];
    startShowText();
    super.initState();
  }

  @override
  void dispose() {
    _textShowController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (finishCurrentTalk) {
          _nextTalk();
        } else {
          _finishTalk();
        }
      },
      child: Container(
        color: Colors.transparent,
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ..._buildPerson(PersonDirection.LEFT),
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
                      stream: _textShowController.stream,
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
            ),
            ..._buildPerson(PersonDirection.RIGHT),
          ],
        ),
      ),
    );
  }

  void _finishTalk() {
    timer.cancel();
    _textShowController.add(currentTalk.text);
    countLetter = 1;
    finishCurrentTalk = true;
  }

  void _nextTalk() {
    currentIndexTalk++;
    if (currentIndexTalk < widget.talks.length) {
      setState(() {
        finishCurrentTalk = false;
        currentTalk = widget.talks[currentIndexTalk];
      });
      startShowText();
    } else {
      Navigator.pop(context);
    }
  }

  void startShowText() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _textShowController.add(currentTalk.text.substring(0, countLetter));
      countLetter++;
      if (countLetter == currentTalk.text.length + 1) {
        timer.cancel();
        countLetter = 1;
        finishCurrentTalk = true;
      }
    });
  }

  List<Widget> _buildPerson(PersonDirection direction) {
    if (currentTalk.personDirection == direction) {
      return [
        if (direction == PersonDirection.RIGHT)
          SizedBox(
            width: 10,
          ),
        currentTalk.person,
        if (direction == PersonDirection.LEFT)
          SizedBox(
            width: 10,
          ),
      ];
    } else {
      return [];
    }
  }
}
