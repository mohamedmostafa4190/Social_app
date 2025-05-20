import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (_prefs == null) throw Exception('SharedPreferences not initialized!');

    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    if (value is String) return await _prefs!.setString(key, value);
    return false;
  }

  static Object? getData({required String key}) {
    return _prefs!.get(key);
  }

  static Future<bool> removeData(String key) async {
    return await _prefs!.remove(key);
  }
}
