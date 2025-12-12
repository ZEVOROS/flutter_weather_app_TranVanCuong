import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';

import 'providers/weather_provider.dart';
import 'providers/location_provider.dart';
import 'providers/settings_provider.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';

    final weatherService = WeatherService(apiKey: apiKey);
    final locationService = LocationService();
    final storageService = StorageService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            weatherService: weatherService,
            locationService: locationService,
            storageService: storageService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(locationService),
        ),

        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: "Weather App",
            debugShowCheckedModeBanner: false,

            theme: settings.isDarkMode
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData.light(useMaterial3: true),

            locale: Locale(settings.language),

            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
