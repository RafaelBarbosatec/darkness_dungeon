import 'dart:async';

import 'package:darkness_dungeon/Menu.dart';
import 'package:darkness_dungeon/player/HealthBar.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.setLandscape();
  await Flame.util.fullScreen();
  runApp(MaterialApp(
    home: Menu(),
  ));
}

class GameWidget extends StatefulWidget {
  final Size size;

  GameWidget({Key key, this.size}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  final GlobalKey<HealthBarState> healthKey = GlobalKey();
  StreamController<bool> streamProgress = StreamController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
//          game.widget,
          Align(
            alignment: Alignment.topLeft,
            child: HealthBar(key: healthKey),
          ),
          _buildProgress(),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: GestureDetector(
//                    behavior: HitTestBehavior.opaque,
//                    onPanStart: game.controller.onPanStart,
//                    onPanUpdate: game.controller.onPanUpdate,
//                    onPanEnd: game.controller.onPanEnd,
//                    onTapDown: game.controller.onTapDown,
//                    onTapUp: game.controller.onTapUp,
//                    child: Container()),
//              ),
//              Expanded(
//                child: GestureDetector(
//                    behavior: HitTestBehavior.opaque,
//                    onTapDown: game.controller.onTapDownAtack,
//                    onTapUp: game.controller.onTapUpAtack,
//                    child: Container()),
//              )
//            ],
//          )
        ],
      ),
    );
  }

  void _showDialogGameOver() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/game_over.png',
                  height: 100,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.transparent,
                  onPressed: () {
                    healthKey.currentState.updateHealth(100);
                    healthKey.currentState.updateStamina(100);
//                    game.resetGame();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 20.0),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _buildProgress() {
    return StreamBuilder(
      stream: streamProgress.stream,
      initialData: true,
      builder: (context, snapshot) {
        bool showProgress = true;

        if (snapshot.hasData) {
          showProgress = snapshot.data;
        }

        return AnimatedOpacity(
          opacity: showProgress ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "Carregando...",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 20.0),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streamProgress.close();
    super.dispose();
  }
}
