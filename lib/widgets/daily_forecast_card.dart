import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

class DailyForecastCard extends StatelessWidget {
  final ForecastModel forecast;
  const DailyForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network('https://openweathermap.org/img/wn/${forecast.icon}@2x.png'),
      title: Text('${forecast.dateTime}'),
      subtitle: Text('${forecast.temperature}°C'),
    );
  }
}
