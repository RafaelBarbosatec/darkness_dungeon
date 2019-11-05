
import 'package:flutter/material.dart';

class HealthBar extends StatefulWidget {

  const HealthBar({Key key}) : super(key: key);

  @override
  HealthBarState createState() => HealthBarState();
}

class HealthBarState extends State<HealthBar> {
  double health = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SizedBox(
              height: 20,
              child: LinearProgressIndicator(value: health,valueColor: AlwaysStoppedAnimation(Colors.red[700]),
              backgroundColor: Colors.transparent,),
            ),
          ),
          Image.asset('assets/images/health_ui.png',height: 20, width: 100, fit: BoxFit.fill,)
        ],
      ),
    );
  }

  void updateHealth(double health){
    setState(() {
      this.health = health/100;
    });
  }
}
