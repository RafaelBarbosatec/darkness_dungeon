import 'package:darkness_dungeon/Menu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.setLandscape();
  await Flame.util.fullScreen();
  runApp(
    MaterialApp(
      home: Menu(),
    ),
  );
}
