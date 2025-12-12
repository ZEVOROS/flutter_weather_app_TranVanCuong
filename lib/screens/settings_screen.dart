import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: settings.isDarkMode,
            onChanged: settings.toggleDarkMode,
          ),

          const Divider(),
          ListTile(
            title: const Text("Temperature Unit"),
            subtitle: Text(settings.unit == TempUnit.celsius ? "Celsius (°C)" : "Fahrenheit (°F)"),
            trailing: DropdownButton<TempUnit>(
              value: settings.unit,
              onChanged: (v) => settings.changeUnit(v!),
              items: const [
                DropdownMenuItem(value: TempUnit.celsius, child: Text("Celsius (°C)")),
                DropdownMenuItem(value: TempUnit.fahrenheit, child: Text("Fahrenheit (°F)")),
              ],
            ),
          ),

          const Divider(),
          ListTile(
            title: const Text("Language"),
            subtitle: Text(settings.language),
            trailing: DropdownButton<String>(
              value: settings.language,
              onChanged: (v) => settings.changeLanguage(v!),
              items: const [
                DropdownMenuItem(value: "en", child: Text("English")),
                DropdownMenuItem(value: "vi", child: Text("Tiếng Việt")),
              ],
            ),
          ),

          const Divider(),
          SwitchListTile(
            title: const Text("Auto Refresh Weather"),
            subtitle: const Text("Automatically update every 15 minutes"),
            value: settings.autoRefresh,
            onChanged: settings.toggleAutoRefresh,
          ),

          if (settings.autoRefresh)
            Slider(
              value: settings.refreshInterval.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              label: "${settings.refreshInterval} minutes",
              onChanged: (v) => settings.changeInterval(v.toInt()),
            ),

          const Divider(),
          ListTile(
            title: const Text("Clear Cache"),
            leading: const Icon(Icons.delete_outline),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cache cleared")),
              );
            },
          ),

        ],
      ),
    );
  }
}
