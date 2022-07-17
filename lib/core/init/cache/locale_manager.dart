import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // get data
  static dynamic getData({
    @required String? key,
  }) {
    return sharedPreferences!.get(key!);
  }

  static Future<bool> saveData({
    @required String? key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setStringList(key!,[]);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    return await sharedPreferences!.setDouble(key!, value);
  }

  // remove user data (token)
  static Future<bool> removeData({@required String? key}) async {
    return await sharedPreferences!.remove(key!);
  }
}

















// import 'package:shared_preferences/shared_preferences.dart';

// import 'enum/locale_keys_enum.dart';

// class LocaleManager {



//   // static Future prefrencesInit() async {
//   //   instance._preferences ??= await SharedPreferences.getInstance();
//   // }

//   Future<void> setStringValue(PreferencesKeys key, String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setString(key.toString(), value);
//   }

//   Future<void> setIntValue(PreferencesKeys key, int value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setInt(key.toString(), value);
//   }

//   Future<void> setBoolValue(PreferencesKeys key, bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setBool(key.toString(), value);
//   }

//   getStringValue(PreferencesKeys key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.getString(key.toString());
//   }

//   getIntValue(PreferencesKeys key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.getInt(key.toString());
//   }

//   getBoolValue(PreferencesKeys key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.getBool(key.toString());
//   }
// }
