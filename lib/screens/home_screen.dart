import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart' as ew;
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Thành phố mặc định
    const defaultCity = "Ho Chi Minh";

    // Gán vào ô TextField
    _searchController.text = defaultCity;

    // Gọi API ngay khi mở app
    Future.microtask(() {
      final weatherProvider = context.read<WeatherProvider>();
      weatherProvider.fetchByCity(defaultCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  final city = _searchController.text.trim();
                  if (city.isNotEmpty) {
                    weatherProvider.fetchByCity(city);
                  }
                },
                icon: const Icon(Icons.search, size: 30),
              )
            ]),

            const SizedBox(height: 20),

            if (weatherProvider.state == WeatherState.loading)
              const LoadingShimmer(),

            if (weatherProvider.state == WeatherState.error)
              ew.ErrorWidgetCustom(message: weatherProvider.error),

            if (weatherProvider.current != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CurrentWeatherCard(weather: weatherProvider.current!),
                      const SizedBox(height: 12),

                      Column(
                        children: weatherProvider.forecast.take(5).map((f) {
                          return ListTile(
                            title: Text('${f.dateTime}'),
                            subtitle: Text('${f.temperature}°C - ${f.description}'),
                            leading: Image.network(
                              'https://openweathermap.org/img/wn/${f.icon}@2x.png',
                              width: 40,
                              height: 40,
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
