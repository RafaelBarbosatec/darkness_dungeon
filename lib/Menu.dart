import 'package:darkness_dungeon/util/conversation.dart';
import 'package:darkness_dungeon/util/talk.dart';
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
              FlameAnimation.Animation.sequenced("player/knight_run.png", 6,
                  textureWidth: 16, textureHeight: 16),
            ),
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
                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Game()),
//                  );
                  Conversation.show(context, [
                    Talk(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis pulvinar libero, sit amet finibus lectus porttitor at. ',
                      Flame.util.animationAsWidget(
                        Position(80, 100),
                        FlameAnimation.Animation.sequenced(
                          "npc/wizard_idle_left.png",
                          4,
                          textureWidth: 16,
                          textureHeight: 22,
                        ),
                      ),
                    ),
                    Talk(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis pulvinar libero, sit amet finibus lectus porttitor at. ',
                      Flame.util.animationAsWidget(
                        Position(80, 100),
                        FlameAnimation.Animation.sequenced(
                          "npc/wizard_idle_left.png",
                          4,
                          textureWidth: 16,
                          textureHeight: 22,
                        ),
                      ),
                      personDirection: PersonDirection.RIGHT,
                    )
                  ]);
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
