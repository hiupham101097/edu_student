import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageData {
  static Future<void> setValue(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  static Future<dynamic> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    try {
      value = prefs.getString(key)!;
      // ignore: empty_catches
    } catch (ex) {}

    return value != null ? json.decode(value) : null;
  }

  static Future<String> getStrValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = "";
    try {
      value = prefs.getString(key)!;
      // ignore: empty_catches
    } catch (ex) {}

    return value;
  }

  static Future<void> deleteValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
