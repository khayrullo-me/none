import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static final MySharedPreference _instance = MySharedPreference._internal();

  MySharedPreference._internal();

  static MySharedPreference get instance => _instance;

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isDark => _prefs?.getBool('isDark') ?? false;

  set isLight(bool value) {
    _prefs?.setBool('isDark', value);
  }


}