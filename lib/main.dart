import 'package:darkness_dungeon/menu.dart';
import 'package:darkness_dungeon/util/localization/my_localizations_delegate.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

double tileSize;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.setLandscape();
  await Flame.util.fullScreen();
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Normal'),
        ),
      ),
      home: Menu(),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
    ),
  );
}
