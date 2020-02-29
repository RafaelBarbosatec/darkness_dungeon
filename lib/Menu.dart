import 'package:darkness_dungeon/new_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Darkness Dungeon",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 30.0)),
            Text("demo",
                style: TextStyle(
                    color: Colors.red, fontFamily: 'Normal', fontSize: 20.0)),
            SizedBox(
              height: 20.0,
            ),
            Flame.util.animationAsWidget(
                Position(50, 50),
                FlameAnimation.Animation.sequenced("knight_run.png", 6,
                    textureWidth: 16, textureHeight: 16)),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Color.fromARGB(255, 118, 82, 78),
                child: Text("PLAY",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 17.0)),
                onPressed: () async {
                  Size size = await Flame.util.initialDimensions();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewGame(
                              size: size,
                            )),
                  );
                })
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 20,
        margin: EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Powered by rafaelbarbosatec",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 12.0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
        theme: FlameSplashTheme.dark,
        onFinish: (BuildContext context) {
          setState(() {
            showSplash = false;
          });
        });
  }
}
