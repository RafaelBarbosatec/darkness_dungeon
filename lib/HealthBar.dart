
import 'package:flutter/material.dart';

class HealthBar extends StatefulWidget {

  const HealthBar({Key key}) : super(key: key);

  @override
  HealthBarState createState() => HealthBarState();
}

class HealthBarState extends State<HealthBar> {

  double health = 1;
  double stamina = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 2.0,top: 3.0),
            child: SizedBox(
              height: 10,
              child: LinearProgressIndicator(value: health,valueColor: AlwaysStoppedAnimation(Colors.red[700]),
              backgroundColor: Colors.transparent,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 2.0,top:15),
            child: SizedBox(
              height: 10,
              child: LinearProgressIndicator(value: stamina,valueColor: AlwaysStoppedAnimation(Colors.yellow[700]),
                backgroundColor: Colors.transparent,),
            ),
          ),
          Image.asset('assets/images/health_ui.png',height: 30, width: 100, fit: BoxFit.fill,)
        ],
      ),
    );
  }

  void updateHealth(double health){
    setState(() {
      this.health = health/100;
    });
  }

  void updateStamina(double stamina){
    setState(() {
      this.stamina = stamina/100;
      if(this.stamina > 1){
        this.stamina = 1;
      }
      if(this.stamina < 0){
        this.stamina = 0;
      }
    });
  }
}
