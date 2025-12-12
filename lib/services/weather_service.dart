import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherService {
  final http.Client httpClient;
  final String apiKey;

  WeatherService({http.Client? httpClient, required this.apiKey})
      : httpClient = httpClient ?? http.Client();

  Future<WeatherModel> getCurrentWeatherByCity(String city) async {
    final url = ApiConfig.buildUrl('/weather', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    final res = await httpClient.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(res.body));
    } else if (res.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception('Failed to load weather: ${res.statusCode}');
    }
  }

  Future<List<ForecastModel>> getForecastByCity(String city) async {
    final url = ApiConfig.buildUrl('/forecast', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    final res = await httpClient.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final list = (data['list'] as List).cast<dynamic>();
      return list.map((e) => ForecastModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load forecast: ${res.statusCode}');
    }
  }

  String iconUrl(String code) =>
      'https://openweathermap.org/img/wn/$code@2x.png';
}
