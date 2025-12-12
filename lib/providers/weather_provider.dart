import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/storage_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService weatherService;
  final StorageService storageService;

  WeatherModel? _current;
  List<ForecastModel> _forecast = [];
  WeatherState _state = WeatherState.initial;
  String _error = '';

  WeatherProvider({required this.weatherService, required this.storageService, required LocationService locationService});

  WeatherModel? get current => _current;
  List<ForecastModel> get forecast => _forecast;
  WeatherState get state => _state;
  String get error => _error;

  Future<void> fetchByCity(String city) async {
    _state = WeatherState.loading;
    notifyListeners();
    try {
      final w = await weatherService.getCurrentWeatherByCity(city);
      final f = await weatherService.getForecastByCity(city);
      _current = w;
      _forecast = f;
      await storageService.saveWeather(w);
      _state = WeatherState.loaded;
      _error = '';
    } catch (e) {
      _state = WeatherState.error;
      _error = e.toString();
      // try to load cached
      final cached = await storageService.getCachedWeather();
      if (cached != null) {
        _current = cached;
        _state = WeatherState.loaded;
      }
    }
    notifyListeners();
  }
}
