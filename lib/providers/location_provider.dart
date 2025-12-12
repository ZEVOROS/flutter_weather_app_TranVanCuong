import 'package:flutter/material.dart';
import '../services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService;

  LocationProvider(this._locationService);

  String currentCity = '';
  bool loading = false;
  String error = '';

  Future<void> fetchCurrentCity() async {
    loading = true;
    notifyListeners();
    try {
      final pos = await _locationService.getCurrentPosition();
      final city = await _locationService.getCityFromCoordinates(pos.latitude, pos.longitude);
      currentCity = city;
      error = '';
    } catch (e) {
      error = e.toString();
    }
    loading = false;
    notifyListeners();
  }
}
