import 'package:darkness_dungeon/menu.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showGameOver(BuildContext context, VoidCallback playAgain) {
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: Text(
                  getString('play_again_cap'),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void showCongratulations(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  getString('congratulations'),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    getString('thanks'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 118, 82, 78)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  child: Text("OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 17.0)),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Menu()),
                      (Route<dynamic> route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
