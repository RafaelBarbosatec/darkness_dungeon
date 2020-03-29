import 'package:flutter/cupertino.dart';

enum PersonDirection { LEFT, RIGHT }

class Talk {
  final String text;
  final Widget person;
  final PersonDirection personDirection;
  Talk(this.text, this.person, {this.personDirection = PersonDirection.LEFT});
}
