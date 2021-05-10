import 'dart:async';

import 'package:darkness_dungeon/game.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  int currentPosition = 0;
  Timer _timer;
  List<Widget> sprites = [
    // Flame.util.animationAsWidget(
    //   Position(80, 80),
    //   FlameAnimation.Animation.sequenced("player/knight_run.png", 6,
    //       textureWidth: 16, textureHeight: 16),
    // ),
    // Flame.util.animationAsWidget(
    //   Position(80, 80),
    //   FlameAnimation.Animation.sequenced("player/knight_idle.png", 6,
    //       textureWidth: 16, textureHeight: 16),
    // ),
    // Flame.util.animationAsWidget(
    //   Position(80, 80),
    //   FlameAnimation.Animation.sequenced(
    //     "enemy/goblin/goblin_run_right.png",
    //     6,
    //     textureWidth: 16,
    //     textureHeight: 16,
    //   ),
    // ),
    // Flame.util.animationAsWidget(
    //   Position(80, 80),
    //   FlameAnimation.Animation.sequenced(
    //     "enemy/goblin/goblin_idle.png",
    //     6,
    //     textureWidth: 16,
    //     textureHeight: 16,
    //   ),
    // ),
    // Flame.util.animationAsWidget(
    //     Position(80, 80),
    //     FlameAnimation.Animation.sequenced(
    //       "enemy/imp/imp_run_right.png",
    //       4,
    //       textureWidth: 16,
    //       textureHeight: 16,
    //     )),
    // Flame.util.animationAsWidget(
    //     Position(80, 80),
    //     FlameAnimation.Animation.sequenced(
    //       "enemy/imp/imp_idle.png",
    //       4,
    //       textureWidth: 16,
    //       textureHeight: 16,
    //     )),
    // Flame.util.animationAsWidget(
    //   Position(70, 80),
    //   FlameAnimation.Animation.sequenced(
    //     "enemy/boss/boss_run_right.png",
    //     4,
    //     textureWidth: 32,
    //     textureHeight: 36,
    //   ),
    // ),
    // Flame.util.animationAsWidget(
    //   Position(70, 80),
    //   FlameAnimation.Animation.sequenced(
    //     "enemy/boss/boss_idle.png",
    //     4,
    //     textureWidth: 32,
    //     textureHeight: 36,
    //   ),
    // ),
  ];

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
  }

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
            Text(
              "Darkness Dungeon",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Normal', fontSize: 30.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            if (sprites.isNotEmpty) sprites[currentPosition],
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: 150,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Color.fromARGB(255, 118, 82, 78),
                child: Text(
                  getString('play_cap'),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Normal',
                    fontSize: 17.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 20,
          margin: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      getString('powered_by'),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 12.0),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL('https://github.com/RafaelBarbosatec');
                      },
                      child: Text(
                        'rafaelbarbosatec',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontFamily: 'Normal',
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      getString('built_with'),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 12.0),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(
                            'https://github.com/RafaelBarbosatec/bonfire');
                      },
                      child: Text(
                        'Bonfire',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontFamily: 'Normal',
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
        startTimer();
      },
    );
  }

  void startTimer() {
    // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //   setState(() {
    //     currentPosition++;
    //     if (currentPosition > sprites.length - 1) {
    //       currentPosition = 0;
    //     }
    //   });
    // });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
