import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const _cacheKey = '__cache__';
  static const int maxKeys = 100;

  static Future<Map<String, String>> _getCacheMap() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) return {};
    return Map<String, String>.from(json.decode(jsonString));
  }

  static Future<void> _saveCacheMap(Map<String, String> map) async {
    final prefs = await SharedPreferences.getInstance();

    while (map.length > maxKeys) {
      String oldestKey = map.keys.first;
      map.remove(oldestKey);
    }

    await prefs.setString(_cacheKey, json.encode(map));
  }

  static Future<void> saveData(String key, dynamic value) async {
    Map<String, String> map = await _getCacheMap();
    map.remove(key);
    map[key] = value;
    await _saveCacheMap(map);
  }

  static Future<String?> getData(String key) async {
    Map<String, String> map = await _getCacheMap();
    return map[key];
  }

  static Future<void> removeData(String key) async {
    Map<String, String> map = await _getCacheMap();
    map.remove(key);
    await _saveCacheMap(map);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}