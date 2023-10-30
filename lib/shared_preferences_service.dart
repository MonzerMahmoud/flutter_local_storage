import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global private constants
const String _kCounterKey = 'counter';

// Single centralized singleton class for shared preferences service
class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Persist and retrieve counter
  int get counter => _getData(_kCounterKey);
  set counter(int value) => _saveData(_kCounterKey, value);


  // Private generic method for retrieving data from shared preferences
  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _preferences.get(key);

    debugPrint('Retrieved $key: $value');

    // Return the data that we retrieve from shared preferences
    return value;
  }

  // Private method for saving data to shared preferences
  void _saveData(String key, dynamic value) {
    debugPrint('Saving $key: $value');

    // Save data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  // Private method for removing data from shared preferences
  void _removeData(String key) async {
    debugPrint('Removing $key');
    _preferences.remove(key);
  }
}
