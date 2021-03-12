import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  Future<bool> save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
    return true;
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  saveBool(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}
  readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key)??false;
  }
  saveString(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)??"";
  }

  clear() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

}