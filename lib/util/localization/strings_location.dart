import 'package:darkness_dungeon/util/localization/my_localizations.dart';

class StringsLocation {
  static final StringsLocation _singleton = new StringsLocation._internal();

  static late MyLocalizations _myLocalizations;

  static void configure(MyLocalizations location) {
    _myLocalizations = location;
  }

  factory StringsLocation() {
    return _singleton;
  }

  StringsLocation._internal();

  String getString(String key) {
    return _myLocalizations.trans(key);
  }
}

String getString(String key) {
  return StringsLocation().getString(key);
}
