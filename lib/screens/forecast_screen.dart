import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';
import 'package:intl/intl.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  String formatTemp(double value, TempUnit unit) {
    if (unit == TempUnit.fahrenheit) {
      return '${(value * 9 / 5 + 32).toStringAsFixed(1)}°F';
    }
    return '${value.toStringAsFixed(1)}°C';
  }

  @override
  Widget build(BuildContext context) {
    final weatherProv = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Day Forecast'),
        centerTitle: true,
      ),

      body: weatherProv.forecast.isEmpty
          ? const Center(
        child: Text('No forecast available'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weatherProv.forecast.length,
        itemBuilder: (context, index) {
          final f = weatherProv.forecast[index];

          final formattedDate =
          DateFormat("EEE, dd MMM • HH:mm").format(f.dateTime);

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Image.network(
                    'https://openweathermap.org/img/wn/${f.icon}@2x.png',
                    width: 55,
                    height: 55,
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          f.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    formatTemp(f.temperature, settings.unit),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
