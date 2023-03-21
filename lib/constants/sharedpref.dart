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

  int? getInt(String key) {
  return _prefs?.getInt(key);
}

Future<bool> setInt(String key, int value) {
  return _prefs?.setInt(key, value) ?? Future.value(false);
}
double? getFloat(String key) {
  return _prefs?.getDouble(key);
}

List<dynamic>?getList(String key) {
  return _prefs?.getStringList(key);
}

Future<bool> setList(String key, List<dynamic> value) {
  return _prefs?.setStringList(key, value.cast<String>()) ?? Future.value(false);
}

Future<bool> setFloat(String key, double value) {
  return _prefs?.setDouble(key, value) ?? Future.value(false);
}


//   Future<bool> setList(String key, List<dynamic> value) async {
//   final prefs = await SharedPreferences.getInstance();
//   try {
//     final jsonString = json.encode(value);
//     return prefs.setString(key, jsonString);
//   } catch (e) {
//     // Handle the error
//     return false;
//   }
// }

// Future<List<dynamic>> getList(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   final jsonString = prefs.getString(key);
//   if (jsonString != null) {
//     try {
//       final list = json.decode(jsonString) as List<dynamic>;
//       return list;
//     } catch (e) {
//       // Handle the error
//     }
//   }
//   return [];
// }

  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  Future<bool> remove(String key) {
    return _prefs?.remove(key) ?? Future.value(false);
  }
}