import 'package:flutter/material.dart';

enum TempUnit { celsius, fahrenheit }

class SettingsProvider extends ChangeNotifier {
  bool isDarkMode = false;
  TempUnit unit = TempUnit.celsius;
  String language = "en";

  bool autoRefresh = false;
  int refreshInterval = 15;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  void changeUnit(TempUnit newUnit) {
    unit = newUnit;
    notifyListeners();
  }

  void changeLanguage(String lang) {
    language = lang;
    notifyListeners();
  }

  void toggleAutoRefresh(bool value) {
    autoRefresh = value;
    notifyListeners();
  }

  void changeInterval(int minutes) {
    refreshInterval = minutes;
    notifyListeners();
  }
}
