import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static final MySharedPreferences _singleton =
      MySharedPreferences._internal();

  factory MySharedPreferences() {
    return _singleton;
  }

  MySharedPreferences._internal();

  SharedPreferences? _prefs;

  Future<void> initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  Future<bool> remove(String key) {
    return _prefs?.remove(key) ?? Future.value(false);
  }
}