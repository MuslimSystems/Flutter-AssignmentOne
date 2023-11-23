import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String key = "counter";

  // Save an integer value to SharedPreferences
  static Future<void> saveCounter(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // Read an integer value from SharedPreferences. If the key is not found, return a default value.
  static Future<int> getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }
}