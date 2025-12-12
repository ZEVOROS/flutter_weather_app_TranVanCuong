import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class StorageService {
  static const _weatherKey = 'cached_weather';
  static const _timeKey = 'cached_time';

  Future<void> saveWeather(WeatherModel w) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weatherKey, json.encode({
      'name': w.cityName,
      'sys': {'country': w.country},
      'main': {'temp': w.temperature, 'feels_like': w.feelsLike, 'humidity': w.humidity, 'pressure': w.pressure},
      'weather': [{'description': w.description, 'icon': w.icon, 'main': w.mainCondition}],
      'dt': w.dateTime.millisecondsSinceEpoch ~/ 1000,
    }));
    await prefs.setInt(_timeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<WeatherModel?> getCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_weatherKey);
    if (s == null) return null;
    final map = json.decode(s);
    return WeatherModel.fromJson(map);
  }

  Future<bool> isCacheValid(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getInt(_timeKey);
    if (t == null) return false;
    return DateTime.now().millisecondsSinceEpoch - t < minutes * 60 * 1000;
  }
}
