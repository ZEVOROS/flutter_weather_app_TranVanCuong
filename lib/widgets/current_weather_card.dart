import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMM d').format(weather.dateTime);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text('${weather.cityName}, ${weather.country}', style: const TextStyle(fontSize: 20)),
            Text(date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
              height: 100,
              placeholder: (c, s) => const SizedBox(height: 100),
              errorWidget: (c, s, e) => const Icon(Icons.error),
            ),
            const SizedBox(height: 8),
            Text('${weather.temperature.round()}°', style: const TextStyle(fontSize: 48)),
            Text(weather.description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Feels like ${weather.feelsLike.round()}°'),
                Text('Humidity ${weather.humidity}%'),
                Text('Wind ${weather.windSpeed} m/s'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
